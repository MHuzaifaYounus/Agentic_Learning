--
-- PostgreSQL database dump
--

\restrict X2dlNtsHSLt5581BweVpELIbfOIiyBqk0tZudiK2ui2JecFezdCsnc5wXdx1x1g

-- Dumped from database version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: elements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.elements (
    id uuid NOT NULL,
    "threadId" uuid,
    type text,
    url text,
    "chainlitKey" text,
    name text NOT NULL,
    display text,
    "objectKey" text,
    size text,
    page integer,
    language text,
    "forId" uuid,
    mime text,
    props jsonb
);


ALTER TABLE public.elements OWNER TO postgres;

--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedbacks (
    id uuid NOT NULL,
    "forId" uuid NOT NULL,
    "threadId" uuid NOT NULL,
    value integer NOT NULL,
    comment text
);


ALTER TABLE public.feedbacks OWNER TO postgres;

--
-- Name: steps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.steps (
    id uuid NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    "threadId" uuid NOT NULL,
    "parentId" uuid,
    streaming boolean NOT NULL,
    "waitForAnswer" boolean,
    "isError" boolean,
    metadata jsonb,
    tags text[],
    input text,
    output text,
    "createdAt" text,
    command text,
    start text,
    "end" text,
    generation jsonb,
    "showInput" text,
    language text,
    indent integer,
    "defaultOpen" boolean
);


ALTER TABLE public.steps OWNER TO postgres;

--
-- Name: threads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.threads (
    id uuid NOT NULL,
    "createdAt" text,
    name text,
    "userId" uuid,
    "userIdentifier" text,
    tags text[],
    metadata jsonb
);


ALTER TABLE public.threads OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    identifier text NOT NULL,
    metadata jsonb NOT NULL,
    "createdAt" text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: elements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.elements (id, "threadId", type, url, "chainlitKey", name, display, "objectKey", size, page, language, "forId", mime, props) FROM stdin;
\.


--
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedbacks (id, "forId", "threadId", value, comment) FROM stdin;
\.


--
-- Data for Name: steps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.steps (id, name, type, "threadId", "parentId", streaming, "waitForAnswer", "isError", metadata, tags, input, output, "createdAt", command, start, "end", generation, "showInput", language, indent, "defaultOpen") FROM stdin;
99232736-f945-4763-bc46-d68f15754953	Agentic Learning	assistant_message	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	4f15bf4b-f86f-4cc9-89c7-96803926b2ab	f	f	f	{}	\N	\N	Hello! What can I do for you today? I can help you plan a lesson if you'd like. \n	2025-10-24T18:10:27.447731Z	\N	2025-10-24T18:10:27.447731Z	2025-10-24T18:10:27.447731Z	{}	\N	\N	\N	\N
4f15bf4b-f86f-4cc9-89c7-96803926b2ab	on_message	run	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	b7821fb0-de3b-47b5-86a0-a4d56059de82	f	\N	f	{}	\N	hi		2025-10-24T18:10:27.443158Z	\N	2025-10-24T18:10:27.443282Z	2025-10-24T18:10:30.519955Z	null	json	\N	\N	f
1201e208-7252-4dac-afdc-2a6aef615095	admin	user_message	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	\N	f	f	f	{"location": "http://localhost:8000/thread/0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01"}	\N	\N	i want to learn about database	2025-10-24T18:11:33.045080Z	\N	2025-10-24T18:11:33.045080Z	2025-10-24T18:11:33.045080Z	{}	\N	\N	\N	\N
debf3cbc-3f76-4736-bdad-069d82f94b14	on_message	run	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	ef18f566-89e7-48c3-91a8-c98fabfde5ef	f	\N	f	{}	\N	some experience ,  learn to design a database, i have used SQL		2025-10-24T18:12:20.421082Z	\N	2025-10-24T18:12:20.421121Z	2025-10-24T18:12:44.907501Z	null	json	\N	\N	f
58ae648f-9dd7-422e-995a-2ac53194f56a	admin	user_message	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	\N	f	f	f	{"location": "http://localhost:8000/thread/0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01"}	\N	\N	start with the first one	2025-10-24T18:13:42.340738Z	\N	2025-10-24T18:13:42.340738Z	2025-10-24T18:13:42.340738Z	{}	\N	\N	\N	\N
f51eb76d-e246-44ab-9a7e-6d7f095e0925	Agentic Learning	assistant_message	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	5617f865-d0f2-4ec2-af4b-7cfc6114c8df	f	f	f	{}	\N	\N	Great! Databases are a fundamental part of computing. To help me create the best learning plan for you, could you tell me a few things:\n\n1.  **What's your current level of experience with databases?** (e.g., complete beginner, some experience, advanced)\n2.  **What are your goals for learning about databases?** (e.g., understand the basics, learn to design a database, work with a specific type of database, prepare for a job interview)\n3.  **Is there anything you already know about databases or related topics?** (e.g., "I know a bit about Excel spreadsheets," or "I've heard of SQL but don't know what it is.")	2025-10-24T18:11:33.052418Z	\N	2025-10-24T18:11:33.052418Z	2025-10-24T18:11:33.052418Z	{}	\N	\N	\N	\N
5617f865-d0f2-4ec2-af4b-7cfc6114c8df	on_message	run	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	1201e208-7252-4dac-afdc-2a6aef615095	f	\N	f	{}	\N	i want to learn about database		2025-10-24T18:11:33.048054Z	\N	2025-10-24T18:11:33.048148Z	2025-10-24T18:11:35.768772Z	null	json	\N	\N	f
ef18f566-89e7-48c3-91a8-c98fabfde5ef	admin	user_message	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	\N	f	f	f	{"location": "http://localhost:8000/thread/0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01"}	\N	\N	some experience ,  learn to design a database, i have used SQL	2025-10-24T18:12:20.417738Z	\N	2025-10-24T18:12:20.417738Z	2025-10-24T18:12:20.417738Z	{}	\N	\N	\N	\N
b7821fb0-de3b-47b5-86a0-a4d56059de82	admin	user_message	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	\N	f	f	f	{"location": "http://localhost:8000/"}	\N	\N	hi	2025-10-24T18:10:27.436922Z	\N	2025-10-24T18:10:27.436922Z	2025-10-24T18:10:27.436922Z	{}	\N	\N	\N	\N
dcda6689-3d64-4094-881f-9671193a6abe	Agentic Learning	assistant_message	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	c79cd22d-0885-4607-8623-46a732025b11	f	f	f	{}	\N	\N	Alright, let's dive into **Lesson 1: Introduction to Database Design**.\n\n### What is Database Design?\n\nAt its core, **database design** is the process of structuring your data. Think of it like designing the blueprint for a library:\n\n*   **You don't just dump all the books in a pile.** You categorize them (fiction, non-fiction), assign unique identifiers (ISBNs), organize them on shelves, and have a system for finding them.\n*   **Similarly, in a database, you don't just throw all your information into one big, messy file.** You break it down into logical, manageable pieces (tables), define the specific types of information each piece will hold (columns/attributes), and establish how these pieces relate to each other.\n\nIt's the art and science of organizing data to meet the needs of your application or organization, ensuring that the data is stored efficiently, consistently, and in a way that allows for easy retrieval and manipulation.\n\n### Why is Good Database Design Crucial?\n\nYou might wonder, "Why go through all this trouble? Can't I just put everything in one big spreadsheet?" While simple data might fit there, as soon as you scale, collaborate, or need to perform complex operations, a well-designed database becomes essential. Here's why:\n\n1.  **Data Integrity:** This is paramount. A good design ensures that your data is accurate, consistent, and reliable.\n    *   **Prevents Duplication:** Imagine having the same customer's address entered 10 times, and they move. You'd have to update it in 10 places, and you might miss one. A good design stores it once.\n    *   **Enforces Rules:** It can automatically prevent things like entering a negative price for a product, or assigning an employee to a department that doesn't exist. This leads to trustworthy data.\n\n2.  **Performance:**\n    *   **Faster Queries:** When data is logically organized and indexed correctly, the database can find the information you need much more quickly. It's like having a well-organized index in a book versus just flipping through every page.\n    *   **Efficient Storage:** By eliminating redundancy, you save disk space, which can be critical for large datasets.\n\n3.  **Scalability:**\n    *   A well-designed database can handle increasing amounts of data and more users without a complete overhaul. It's built to grow. If you need to add a new type of information, a flexible design makes it easier.\n\n4.  **Maintainability & Flexibility:**\n    *   **Easier Updates:** Changing data or adding new features to your application becomes much simpler when the underlying data structure is logical and clear.\n    *   **Understandability:** Other developers (or even you in six months!) can easily understand how the data is structured, which makes collaboration and future development much smoother.\n\n5.  **Application Development:**\n    *   **Simpler Code:** Your application's code becomes less complex because it doesn't have to constantly deal with messy, inconsistent data. The database itself handles much of the data validation and relationships.\n    *   **Robust Applications:** Applications built on a solid database foundation are less prone to bugs and more reliable.\n\n### In Summary:\n\nThink of database design as laying a strong foundation for a house. You can try to build a house on shaky ground, but it will eventually crack, fall apart, or be very difficult to expand. A strong foundation (good database design) supports a stable, efficient, and flexible structure that can stand the test of time and adapt to future needs.\n\n---\n\n**Your Turn:**\n\nDoes this introduction make sense? Do you have any initial questions about *why* database design is so important?	2025-10-24T18:13:42.347917Z	\N	2025-10-24T18:13:42.347917Z	2025-10-24T18:13:42.347917Z	{}	\N	\N	\N	\N
00e0a8e9-fe56-4fcb-b469-7adc335d6ca1	Agentic Learning	assistant_message	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	debf3cbc-3f76-4736-bdad-069d82f94b14	f	f	f	{}	\N	\N	Here’s a level-appropriate plan to help you learn database design. We’ll start with understanding the 'why' of database design, move through the essential steps of conceptual and logical modeling, delve into normalization, and conclude with practical implementation and maintenance strategies.\n\nHere is your plan:\n\n1.  **Introduction to Database Design** — Understand why good database design is crucial for data integrity, performance, and application development. Objective: Grasp the fundamental importance and benefits of a well-designed database.\n2.  **Requirements Gathering & Conceptual Modeling** — Learn how to translate real-world needs into a conceptual model using Entity-Relationship Diagrams (ERDs). Objective: Be able to identify entities, attributes, and relationships and represent them conceptually.\n3.  **Logical Design: The Relational Model** — Translate conceptual ERDs into a relational schema, defining tables, primary keys, and foreign keys. Objective: Convert a conceptual design into a logical database structure ready for implementation.\n4.  **Normalization Fundamentals (1NF, 2NF, 3NF)** — Understand the principles of normalization to eliminate data redundancy and improve data integrity. Objective: Apply the first three normal forms to refine table structures and prevent common data anomalies.\n5.  **Advanced Normalization & Denormalization** — Explore Boyce-Codd Normal Form (BCNF) and understand when and why to intentionally denormalize a database for performance. Objective: Recognize advanced normalization needs and make informed decisions about denormalization trade-offs.\n6.  **Physical Design Considerations** — Learn about practical choices like data types, indexing strategies, and database objects (views, stored procedures) to optimize performance. Objective: Make informed decisions about physical implementation details to enhance database efficiency.\n7.  **Implementing & Maintaining Your Design** — Put your design into practice using SQL DDL, define constraints, and understand basic strategies for database evolution and security. Objective: Translate your logical design into a functional database schema and understand principles for its ongoing management.	2025-10-24T18:12:20.425039Z	\N	2025-10-24T18:12:20.425039Z	2025-10-24T18:12:20.425039Z	{}	\N	\N	\N	\N
c79cd22d-0885-4607-8623-46a732025b11	on_message	run	0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	58ae648f-9dd7-422e-995a-2ac53194f56a	f	\N	f	{}	\N	start with the first one		2025-10-24T18:13:42.344279Z	\N	2025-10-24T18:13:42.344306Z	2025-10-24T18:13:56.309575Z	null	json	\N	\N	f
\.


--
-- Data for Name: threads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.threads (id, "createdAt", name, "userId", "userIdentifier", tags, metadata) FROM stdin;
ff54e977-07be-4d1c-bde1-e2e3abd08ef7	\N	\N	\N	\N	\N	{"id": "99d05e09-d8e7-4e87-ad82-279aa58fcb71", "env": {}, "state": {"messages": [{"user": "hi"}, {"asisstant": "Hello! I am a Planner Agent. I can help you plan a learning session. What topic would you like to learn about today? What are your learning goals? What is your current level of knowledge on this topic?"}, {"user": "my name is huzaifa"}, {"asisstant": "Nice to meet you, Huzaifa!\\n\\nTo help you plan a learning session, please tell me:\\n\\n*   **What topic would you like to learn about today?**\\n*   **What are your learning goals?**\\n*   **What is your current level of knowledge on this topic?**"}, {"user": "whats my name"}, {"asisstant": "Your name is Huzaifa."}]}, "client_type": "webapp", "chat_history": [{"role": "system", "content": "Conversation so far:[{'role': 'system', 'content': \\"Conversation so far:[{'role': 'system', 'content': 'Conversation so far:[]'}, {'role': 'user', 'content': 'hi'}, {'role': 'assistant', 'content': 'Hello! I am a Planner Agent. I can help you plan a learning session. What topic would you like to learn about today? What are your learning goals? What is your current level of knowledge on this topic?\\\\\\\\n'}]\\"}, {'role': 'user', 'content': 'my name is huzaifa'}, {'role': 'assistant', 'content': 'Nice to meet you, Huzaifa!\\\\n\\\\nTo help you plan a learning session, please tell me:\\\\n\\\\n*   **What topic would you like to learn about today?**\\\\n*   **What are your learning goals?**\\\\n*   **What is your current level of knowledge on this topic?**'}]"}, {"role": "user", "content": "whats my name"}, {"role": "assistant", "content": "Your name is Huzaifa."}], "chat_settings": {}}
0db1b9aa-2f48-48dc-b2a5-f5362d0a3c01	2025-10-24T23:14:00.706083Z	DATABASES	c57ba84e-d7bb-49ae-8b4e-e41a10cf0687	admin	\N	{"env": {}, "state": {"messages": [{"user": "hi"}, {"asisstant": "Hello! What can I do for you today? I can help you plan a lesson if you'd like."}, {"user": "i want to learn about database"}, {"asisstant": "Great! Databases are a fundamental part of computing. To help me create the best learning plan for you, could you tell me a few things:\\n\\n1.  **What's your current level of experience with databases?** (e.g., complete beginner, some experience, advanced)\\n2.  **What are your goals for learning about databases?** (e.g., understand the basics, learn to design a database, work with a specific type of database, prepare for a job interview)\\n3.  **Is there anything you already know about databases or related topics?** (e.g., \\"I know a bit about Excel spreadsheets,\\" or \\"I've heard of SQL but don't know what it is.\\")"}, {"user": "some experience ,  learn to design a database, i have used SQL"}, {"asisstant": "Here’s a level-appropriate plan to help you learn database design. We’ll start with understanding the 'why' of database design, move through the essential steps of conceptual and logical modeling, delve into normalization, and conclude with practical implementation and maintenance strategies.\\n\\nHere is your plan:\\n\\n1.  **Introduction to Database Design** — Understand why good database design is crucial for data integrity, performance, and application development. Objective: Grasp the fundamental importance and benefits of a well-designed database.\\n2.  **Requirements Gathering & Conceptual Modeling** — Learn how to translate real-world needs into a conceptual model using Entity-Relationship Diagrams (ERDs). Objective: Be able to identify entities, attributes, and relationships and represent them conceptually.\\n3.  **Logical Design: The Relational Model** — Translate conceptual ERDs into a relational schema, defining tables, primary keys, and foreign keys. Objective: Convert a conceptual design into a logical database structure ready for implementation.\\n4.  **Normalization Fundamentals (1NF, 2NF, 3NF)** — Understand the principles of normalization to eliminate data redundancy and improve data integrity. Objective: Apply the first three normal forms to refine table structures and prevent common data anomalies.\\n5.  **Advanced Normalization & Denormalization** — Explore Boyce-Codd Normal Form (BCNF) and understand when and why to intentionally denormalize a database for performance. Objective: Recognize advanced normalization needs and make informed decisions about denormalization trade-offs.\\n6.  **Physical Design Considerations** — Learn about practical choices like data types, indexing strategies, and database objects (views, stored procedures) to optimize performance. Objective: Make informed decisions about physical implementation details to enhance database efficiency.\\n7.  **Implementing & Maintaining Your Design** — Put your design into practice using SQL DDL, define constraints, and understand basic strategies for database evolution and security. Objective: Translate your logical design into a functional database schema and understand principles for its ongoing management."}, {"user": "start with the first one"}, {"asisstant": "Alright, let's dive into **Lesson 1: Introduction to Database Design**.\\n\\n### What is Database Design?\\n\\nAt its core, **database design** is the process of structuring your data. Think of it like designing the blueprint for a library:\\n\\n*   **You don't just dump all the books in a pile.** You categorize them (fiction, non-fiction), assign unique identifiers (ISBNs), organize them on shelves, and have a system for finding them.\\n*   **Similarly, in a database, you don't just throw all your information into one big, messy file.** You break it down into logical, manageable pieces (tables), define the specific types of information each piece will hold (columns/attributes), and establish how these pieces relate to each other.\\n\\nIt's the art and science of organizing data to meet the needs of your application or organization, ensuring that the data is stored efficiently, consistently, and in a way that allows for easy retrieval and manipulation.\\n\\n### Why is Good Database Design Crucial?\\n\\nYou might wonder, \\"Why go through all this trouble? Can't I just put everything in one big spreadsheet?\\" While simple data might fit there, as soon as you scale, collaborate, or need to perform complex operations, a well-designed database becomes essential. Here's why:\\n\\n1.  **Data Integrity:** This is paramount. A good design ensures that your data is accurate, consistent, and reliable.\\n    *   **Prevents Duplication:** Imagine having the same customer's address entered 10 times, and they move. You'd have to update it in 10 places, and you might miss one. A good design stores it once.\\n    *   **Enforces Rules:** It can automatically prevent things like entering a negative price for a product, or assigning an employee to a department that doesn't exist. This leads to trustworthy data.\\n\\n2.  **Performance:**\\n    *   **Faster Queries:** When data is logically organized and indexed correctly, the database can find the information you need much more quickly. It's like having a well-organized index in a book versus just flipping through every page.\\n    *   **Efficient Storage:** By eliminating redundancy, you save disk space, which can be critical for large datasets.\\n\\n3.  **Scalability:**\\n    *   A well-designed database can handle increasing amounts of data and more users without a complete overhaul. It's built to grow. If you need to add a new type of information, a flexible design makes it easier.\\n\\n4.  **Maintainability & Flexibility:**\\n    *   **Easier Updates:** Changing data or adding new features to your application becomes much simpler when the underlying data structure is logical and clear.\\n    *   **Understandability:** Other developers (or even you in six months!) can easily understand how the data is structured, which makes collaboration and future development much smoother.\\n\\n5.  **Application Development:**\\n    *   **Simpler Code:** Your application's code becomes less complex because it doesn't have to constantly deal with messy, inconsistent data. The database itself handles much of the data validation and relationships.\\n    *   **Robust Applications:** Applications built on a solid database foundation are less prone to bugs and more reliable.\\n\\n### In Summary:\\n\\nThink of database design as laying a strong foundation for a house. You can try to build a house on shaky ground, but it will eventually crack, fall apart, or be very difficult to expand. A strong foundation (good database design) supports a stable, efficient, and flexible structure that can stand the test of time and adapt to future needs.\\n\\n---\\n\\n**Your Turn:**\\n\\nDoes this introduction make sense? Do you have any initial questions about *why* database design is so important?"}]}, "client_type": "webapp", "chat_settings": {}}
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, identifier, metadata, "createdAt") FROM stdin;
6386497f-4674-42e4-b181-03a93abb45cd	huza	{"role": "admin"}	2025-10-24 22:31:36.959829+05
c57ba84e-d7bb-49ae-8b4e-e41a10cf0687	admin	{"role": "admin", "provider": "credentials"}	2025-10-24T22:45:20.786659Z
\.


--
-- Name: elements elements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_pkey PRIMARY KEY (id);


--
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: steps steps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_pkey PRIMARY KEY (id);


--
-- Name: threads threads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_pkey PRIMARY KEY (id);


--
-- Name: users users_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_identifier_key UNIQUE (identifier);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: elements elements_threadId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT "elements_threadId_fkey" FOREIGN KEY ("threadId") REFERENCES public.threads(id) ON DELETE CASCADE;


--
-- Name: feedbacks feedbacks_threadId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT "feedbacks_threadId_fkey" FOREIGN KEY ("threadId") REFERENCES public.threads(id) ON DELETE CASCADE;


--
-- Name: steps steps_threadId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT "steps_threadId_fkey" FOREIGN KEY ("threadId") REFERENCES public.threads(id) ON DELETE CASCADE;


--
-- Name: threads threads_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT "threads_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: TABLE elements; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.elements TO huza;


--
-- Name: TABLE feedbacks; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.feedbacks TO huza;


--
-- Name: TABLE steps; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.steps TO huza;


--
-- Name: TABLE threads; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.threads TO huza;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO huza;


--
-- PostgreSQL database dump complete
--

\unrestrict X2dlNtsHSLt5581BweVpELIbfOIiyBqk0tZudiK2ui2JecFezdCsnc5wXdx1x1g

