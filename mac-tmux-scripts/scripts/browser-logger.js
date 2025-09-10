
(function() {
    const originalLog = console.log;
    console.log = function(...args) {
        originalLog.apply(console, args);
        fetch('http://localhost:8080/log', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ message: args.join(' ') }),
        });
    };
})();
