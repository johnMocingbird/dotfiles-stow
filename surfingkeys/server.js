const http = require('http');
const fs = require('fs');
const path = require('path');
const os = require('os');

const PORT = 3030;
const CONFIG_FILE = path.join(__dirname, '.config/surfingkeys/surfingkeys.js');

// Get local IP address
function getLocalIP() {
    const interfaces = os.networkInterfaces();
    for (const name of Object.keys(interfaces)) {
        for (const interface of interfaces[name]) {
            if (interface.family === 'IPv4' && !interface.internal) {
                return interface.address;
            }
        }
    }
    return 'localhost';
}

const server = http.createServer((req, res) => {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);

    // Handle CORS for browser access
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    if (req.method === 'OPTIONS') {
        res.writeHead(200);
        res.end();
        return;
    }

    // Serve SurfingKeys config
    if (req.url === '/surfingkeys' || req.url === '/surfingkeys.js') {
        try {
            const config = fs.readFileSync(CONFIG_FILE, 'utf8');

            res.writeHead(200, {
                'Content-Type': 'application/javascript',
                'Cache-Control': 'no-cache'  // Always get latest version
            });
            res.end(config);
        } catch (error) {
            console.error('Error reading SurfingKeys config:', error);
            res.writeHead(404, { 'Content-Type': 'text/plain' });
            res.end('SurfingKeys config file not found');
        }
        return;
    }

    // Simple status page
    if (req.url === '/' || req.url === '/status') {
        const localIP = getLocalIP();
        const html = `
<!DOCTYPE html>
<html>
<head>
    <title>SurfingKeys Config Server</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; padding: 2rem; max-width: 600px; }
        .url { background: #f5f5f5; padding: 0.5rem; border-radius: 4px; font-family: monospace; }
        .status { color: #28a745; font-weight: bold; }
    </style>
</head>
<body>
    <h1>🏄‍♂️ SurfingKeys Config Server</h1>
    <p class="status">✅ Server running on port ${PORT}</p>

    <h2>Access URLs:</h2>
    <p><strong>Local:</strong><br>
    <code class="url">http://localhost:${PORT}/surfingkeys</code></p>

    <p><strong>Network:</strong><br>
    <code class="url">http://${localIP}:${PORT}/surfingkeys</code></p>

    <h2>How to use:</h2>
    <ol>
        <li>Install SurfingKeys browser extension</li>
        <li>Go to SurfingKeys settings</li>
        <li>Set "Load settings from" to one of the URLs above</li>
        <li>Save and reload any page to test</li>
    </ol>

    <h2>Available endpoints:</h2>
    <ul>
        <li><a href="/surfingkeys">/surfingkeys</a> - SurfingKeys configuration file</li>
        <li><a href="/status">/status</a> - This status page</li>
    </ul>

    <p><small>Last updated: ${new Date().toLocaleString()}</small></p>
</body>
</html>`;

        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(html);
        return;
    }

    // 404 for other routes
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Not found');
});

server.listen(PORT, '0.0.0.0', () => {
    const localIP = getLocalIP();
    console.log('\n🏄‍♂️ SurfingKeys Config Server Started!');
    console.log('='.repeat(50));
    console.log(`📍 Local:   http://localhost:${PORT}/surfingkeys`);
    console.log(`🌐 Network: http://${localIP}:${PORT}/surfingkeys`);
    console.log(`📊 Status:  http://${localIP}:${PORT}/status`);
    console.log('='.repeat(50));
    console.log('Press Ctrl+C to stop the server\n');
});

// Graceful shutdown
process.on('SIGINT', () => {
    console.log('\n👋 Shutting down SurfingKeys server...');
    server.close(() => {
        console.log('Server stopped');
        process.exit(0);
    });
});