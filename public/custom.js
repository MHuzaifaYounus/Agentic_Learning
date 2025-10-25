// Custom JavaScript for Chainlit App


// Function to add fading animation to thinking messages
function addFadingAnimation() {
    // Create CSS animation if it doesn't exist
    if (!document.getElementById('fading-animation-styles')) {
        const style = document.createElement('style');
        style.id = 'fading-animation-styles';
        style.textContent = `
            @keyframes fadeInOut {
                0% { opacity: 0.3; }
                50% { opacity: 1; }
                100% { opacity: 0.3; }
            }
            .thinking-message {
                animation: fadeInOut 1.5s ease-in-out infinite;
            }
        `;
        document.head.appendChild(style);
    }

    // Function to check and animate thinking messages
    function checkForThinkingMessages() {
        const messages = document.querySelectorAll('.cl-message, [class*="message"]');
        
        messages.forEach(message => {
            const text = message.textContent || message.innerText || '';
            
            // Check if message contains thinking/loading text
            if (text.includes('Thinking') || text.includes('Loading') || text.includes('Processing')) {
                message.classList.add('thinking-message');
            } else {
                message.classList.remove('thinking-message');
            }
        });
    }

    // Check for thinking messages periodically
    setInterval(checkForThinkingMessages, 100);

    // Also check when new messages are added
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.type === 'childList') {
                checkForThinkingMessages();
            }
        });
    });

    // Start observing
    observer.observe(document.body, {
        childList: true,
        subtree: true
    });
}

// Run when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded',addFadingAnimation);
} else {
  
    addFadingAnimation();
}
