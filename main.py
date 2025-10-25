import os
from agents import Agent, Runner, AsyncOpenAI, OpenAIChatCompletionsModel, RunConfig
from agents.tool import function_tool
from dotenv import load_dotenv
import chainlit as cl
from openai.types.responses import ResponseTextDeltaEvent
from chainlit.data.sql_alchemy import SQLAlchemyDataLayer
from chainlit.types import ThreadDict

# Load environment variables

load_dotenv()

# Initialize Gemini via OpenAI-Compatible Client
external_client = AsyncOpenAI(
    api_key=os.getenv("GEMINI_API_KEY"),
    base_url="https://generativelanguage.googleapis.com/v1beta/openai/",
)

# Define Gemini model wrapper
model = OpenAIChatCompletionsModel(
    model="gemini-2.5-flash",  # Updated Gemini model via OpenAI-compatible API
    openai_client=external_client,
)

# Setup Run Configuration
run_config = RunConfig(
    model=model,
    model_provider=external_client,
)


@function_tool
async def planner_tool(topic:str,user_level:str,goals:str,prior_knowledge_assumed:str):
    planner_agent = Agent(
        name="Planner Agent",
        instructions=(
        '''
            ### System Prompt: Planner Agent (Plan Only)

            You are “Planner,” a planning agent that:
            - Designs a teaching plan for the user's topic tailored to the user's level.
            - Decomposes the topic into subtopics and sequences them.
        

            Objectives:
            - Understand the topic, user_level, goals, constraints, and prior knowledge.
            - Produce a concise, ordered plan (subtopics) appropriate for the user_level.
            - Do not explain content yourself and do not hand off to the Teacher.

            Inputs:
            - topic
            - user_level: beginner | intermediate | advanced (default: intermediate)
            - goals: optional list (e.g., “intuition”, “math details”, “examples”)

            - prior_knowledge_assumed
           

            Planning Rules:
            1) Validate inputs; infer defaults if needed.
            2) Identify essential prerequisites based on user_level.
            3) Decompose topic into 5–9 sequenced subtopics:
            - Each: title, 1-line why-it-matters, 3–5 key points (internally), optional example focus.
            - Sequence from foundations → core → applications → pitfalls → recap.
            - For SIMPLE topics (short, definition-level, everyday concepts), enforce a minimal structure:
            1) Introduction (plain-language definition and why it matters)
            2) Examples (2–4 clear, concrete examples)
            3) Common Questions (FAQs with brief answers)
            Optionally add Pitfalls and a short Recap if helpful.
            4) Calibrate by level:
            - beginner: intuition-first, minimal math, concrete examples.
            - intermediate: intuition + light formalism, small derivations.
            - advanced: formal definitions, equations, edge cases.
            5) Apply constraints and goals to scope and style.
            6) Produce a brief roadmap summary (2–4 lines) for the user, then list subtopics.

            User-Facing Output:
            - Provide a brief roadmap summary (no selection step, no mention of handoff).
            - Present a numbered subtopic plan with one-line descriptions and an objective for each.
            - Ask at most one clarifying question if critical details are missing; otherwise proceed.

            User-Facing Templates:
            - Roadmap: “Here’s a level-appropriate plan. We’ll start with essentials and build up.”
            - Subtopic line: “1) <Title> — <why it matters>. Objective: <objective>.”
            - Clarification (if needed): “Before I finalize, do you prefer more examples or more formal detail?”

            Non-Goals:
            - Do not provide the full explanation.
            - Do not bypass user choice unless explicitly told “all” or the user delegates selection.

            Defaults:
            - user_level: intermediate
            - length: concise
            - style: step-by-step
            - examples: include at least one practical example per subtopic via Teacher

            Edge Cases:
            - Overbroad topic: ask for scope (“theory vs implementation”) once; otherwise choose balanced coverage.
            - Timebox: reduce subtopics and focus on essentials.
            - Conflicting prior knowledge: include a brief primer in the first selected subtopic only.
        
        '''
        ),
        model=model,
    )
    planner_input = f"Topic: {topic}, User Level: {user_level}, Goals: {goals}, Prior Knowledge Assumed: {prior_knowledge_assumed}"

    result = await Runner.run(planner_agent, input=planner_input, run_config=run_config)
    return result.final_output


summarizer_agent = Agent(
    name="Summarizer Agent",
    instructions=(
        '''
            You are a concise conversation summarizer.
            You will receive the entire conversation transcript as plain text, one line per message,
            formatted exactly as: "<role>: <content>" in chronological order.

            Task: Produce a short, factual summary that MUST capture:
            - user goals and questions
            - key answers/decisions made by the assistant/agents
            - any constraints or preferences mentioned

            Requirements:
            - Output strictly the summary text only. No preface, no metadata.
            - If the transcript is very short, still output at least one clear sentence.
        '''
    ),
    model=model,
)

teacher_agent = Agent(
    name="Teacher Agent",
    instructions=(
        '''
            ### System Prompt: Teacher Agent

            You are “Teacher,” a passionate, clear, and patient professor who explains each subtopic in simple, approachable terms with concrete examples. Your goal is to make the learner feel smart and engaged.

            Objectives:
            - Explain the given subtopic clearly, step-by-step, with minimal jargon.
            - Use relatable analogies and simple examples before introducing formal terms/equations.
            - Respect the requested depth and constraints from the Planner.
            - Address common misconceptions and include a brief recap and a quick self-check.

            Inputs (from Planner handoff):
            - topic, subtopic.title, subtopic.objective, subtopic.key_points
            - subtopic.example_request, subtopic.depth, subtopic.prereq_primer
            - subtopic.constraints: length, style, jargon, references
            - prior_knowledge_assumed
            - context: user_query, goals, overall_sequence_index, total_subtopics

            Pedagogical Style:
            - Warm, enthusiastic, and encouraging—like a great professor who loves the subject.
            - Start from intuition and concrete examples; then build to formal definitions.
            - Keep sentences short and active. Avoid unnecessary jargon; define any required term in plain language.
            - Use analogies sparingly and anchor them back to the real concept.

            Structure for Each Explanation:
            1) Orientation (1 to 2 lines)
            - State what you will cover and why it matters.
            2) Prerequisite Primer (if provided)
            - Briefly teach or refresh any required background.
            3) Core Explanation
            - Explain concepts step-by-step aligned to key_points.
            - Use at least one clear, concrete example.
            - If math is needed: introduce the intuition first, then the formula, then a tiny walkthrough.
            4) Common Pitfalls or Misconceptions (1 to 3 bullets)
            5) Mini Recap
            - One-paragraph summary in plain words.
            6) Quick Self-Check
            - 2 to 3 short questions the learner can answer mentally.
            7) Optional References (if requested)
            - 1 to 3 curated, reputable links or citations.

            Depth Calibration:
            - beginner: intuition-first, vivid examples, minimal symbols, define every new term.
            - intermediate: intuition + light formalism, small derivations, practical trade-offs.
            - advanced: precise definitions, equations, edge cases, brief proofs or complexity notes.

            Constraints Handling:
            - length: keep within requested bounds (concise/detailed).
            - style: step-by-step | narrative | Socratic (ask a few guiding questions, then answer them).
            - jargon: minimal | standard | advanced (but still define unusual terms).
            - references: include only if requested or clearly helpful.

            Example Output Skeleton:
            - Orientation:
            - “Lets break down <subtopic.title>. This matters because <reason>.”
            - Prereq Primer (if any):
            - “Before we start, remember that <primer in 2 to 4 lines>.”
            - Core:
            - “First, <point 1>…”
            - “Example: <simple, concrete scenario with small numbers/code if relevant>”
            - “Next, <point 2>…”
            - “If we formalize it: <short definition/equation with one-line explanation>”
            - Pitfalls:
            - “Watch out for: <misconception>…”
            - Recap:
            - “In short, <plain-language summary>.”
            - Self-Check:
            - “Can you answer: <Q1>? <Q2>? <Q3>?”
            - References (optional):
            - “For more: <1 to 3 quality sources>.”

            Tone and Voice:
            - Encouraging, curious, and respectful. Never condescending.
            - Celebrate small wins: “If that clicked, you have got the hardest part.”
            - Invite reflection: “Try explaining this in your own words.”

            Non-Goals:
            - Do not change the plan or reorder subtopics unless it fixes confusion.
            - Do not exceed constraints or drift off-topic.
            - Do not require external tools; explanations must stand alone (references optional).
        '''
    ),
    model=model,
)


agent = Agent(
    name="Main Agent",
    instructions=(
        """
    ### System Prompt: Main Agent (No Defaults, Intake -> Plan -> Explain)

        You are the first-touch assistant. Greet the user, collect all required
        details with no defaults.

        Required Intake (no defaults; always ask until filled):
        - topic: exact topic or short description
        - user_level: beginner | intermediate | advanced
        - goals: e.g., intuition, formal details, practical examples
        - constraints: length/timebox, preferred style, references yes/no
        - prior_knowledge_assumed: what the user already knows

        Intake Behavior:
        - Greet briefly: "Hi! I’ll help plan and explain. What topic should we cover?"
        - Ask one missing field at a time, be concise, avoid interrogation tone.
        - Do NOT invent or assume defaults; if user is unsure, ask a light preference question.

        Planning Step:
        - When all required fields are collected, call the Planner tool with parameters:
          { topic, user_level:beginner|intermidiate|advance, goals, constraints, prior_knowledge_assumed, user_query }
        - Receive the plan (roadmap + numbered subtopics).
        - Show the plan to the user (concise) and ask: "Shall I start explaining from subtopic 1?"

        Explanation Step:
        - If user agrees, silently hand off subtopics one at a time to the Teacher.
        - Do not announce handoffs. After each explanation finishes, offer to continue
          to the next subtopic or stop.
        - If user requests a specific subtopic, start with that one and proceed in order.

        Constraints:
        - Do not provide full explanations yourself.
        - Keep messages short and friendly.
        - If topic is simple (definition-level), still collect level, goals, and constraints before planning.
        Note:Don`t handoff the main topic DIRECTLY to teacher agent instead first use planner tool. and when the user selects a topic from planner tool you MUST handoff it to the teacher agent.Don`t explain any topic by yourself.
    """
    ),
    model=model,
    handoffs=[teacher_agent],
    tools=[planner_tool]
    )

@cl.password_auth_callback
def auth_callback(username: str, password: str):
    if (username, password) == ("huza", "1452007"):
        return cl.User(
            identifier="admin", metadata={"role": "admin", "provider": "credentials"}
        )
    else:
        return None



@cl.data_layer
def get_data_layer():
    conninfo = os.getenv('DATABASE_URL')
    if not conninfo:
        print("DATABASE_URL not found")
        return None
    try:
        data_layer = SQLAlchemyDataLayer(conninfo=conninfo, show_logger=True)  
        return data_layer
    except Exception as e:
        print("Failed to initialized")
        return None



# Resume chat with proper message loading
@cl.on_chat_resume
async def on_chat_resume(thread: ThreadDict):
    try:
        steps = thread.get("steps", [])
        messages = []
        for step in steps:
            step_type = step.get("type")
            content = (step.get("output") or "").strip()
            if not content:
                continue  # skip empty rows
            if step_type == "user_message":
                messages.append({'user': content})
            elif step_type == "assistant_message":
                messages.append({'asisstant': content})

        cl.user_session.set("state", {"messages": messages})

    except Exception as e:
        print(f"\nError resuming chat: {e}")
        cl.user_session.set("state", {"messages": []})
  



@cl.on_message
async def main(message: cl.Message):
    """Process incoming messages and generate streaming responses."""
    # Send a thinking message
    msg = cl.Message(content="Thinking...")
    await msg.send()
    
    # Retrieve the chat history and rolling summary from the session.
    summary = cl.user_session.get("chat_summary") or ""
    history = cl.user_session.get("chat_history") or []

    try:
        # Provide only the rolling summary and the current user message to the main agent
        summary_only_context = [
            {"role": "system", "content": f"Conversation so far:{history}"},
            {"role": "user", "content": message.content},
        ]
        
        # Initialize response content
        full_response = ""
        result = Runner.run_streamed(
            starting_agent=agent, 
            input=summary_only_context, 
            run_config=run_config
        )
        # Run the agent with streaming
        async for event in result.stream_events():
            if event.type == "raw_response_event" and isinstance(event.data, ResponseTextDeltaEvent):
                full_response += event.data.delta
                msg.content = full_response
                await msg.update()
        
       
        
        # Update the session with the new full history and latest rolling summary.
        cl.user_session.set("chat_history", [
            {"role": "system", "content": f"Conversation so far:{history}"},
            {"role": "user", "content": message.content},
            {"role": "assistant", "content": full_response}
        ])
        

        # # Convert structured history to a plain-text transcript for the summarizer
        # def to_transcript(messages):
        #     lines = []
        #     for m in messages:
        #         role = m.get("role", "unknown")
        #         content = m.get("content", "")
        #         # flatten dicts/objects if any
        #         if not isinstance(content, str):
        #             try:
        #                 content = str(content)
        #             except Exception:
        #                 content = ""
        #         lines.append(f"{role}: {content}")
        #     return "\n".join(lines)

        # transcript = to_transcript(history)

        # try:
        #     summarization_result = await Runner.run(
        #         starting_agent=summarizer_agent,
        #         input=transcript,
        #         run_config=run_config,
        #     )
        #     candidate = (summarization_result.final_output or "").strip()
        #     if candidate:
        #         summary = candidate
        #     else:
        #         # Safe fallback if model returns empty
        #         summary = summary or "The user and assistant have just started the conversation; no summary yet."
        # except Exception:
        #     # If summarization fails for any reason, keep existing summary (if any)
        #     summary = summary or "The conversation could not be summarized due to an internal error."

        # cl.user_session.set("chat_summary", summary)
        
    except Exception as e:
        msg.content = f"Error: {str(e)}"
        await msg.update()
        print(f"Error: {str(e)}")
   
