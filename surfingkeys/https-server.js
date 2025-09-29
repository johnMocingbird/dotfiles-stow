const https = require('https');
const fs = require('fs');
const path = require('path');
const os = require('os');

const PORT = 3443;  // HTTPS port
const CONFIG_FILE = path.join(__dirname, '.config/surfingkeys/surfingkeys.js');

// Create self-signed certificate for local development
const selfsigned = require('selfsigned');
const attrs = [{ name: 'commonName', value: 'localhost' }];
const pems = selfsigned.generate(attrs, { days: 365 });

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

const options = {
    key: pems.private,
    cert: pems.cert
};

const server = https.createServer(options, (req, res) => {
    const timestamp = new Date().toISOString();
    console.log(`${timestamp} - ${req.method} ${req.url} from ${req.connection.remoteAddress}`);

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
            console.log(`${timestamp} - Serving config (${config.length} bytes)`);

            res.writeHead(200, {
                'Content-Type': 'application/javascript; charset=utf-8',
                'Cache-Control': 'no-cache, no-store, must-revalidate',
                'Pragma': 'no-cache',
                'Expires': '0',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET, OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type'
            });
            res.end(config, 'utf8');
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
    <title>SurfingKeys HTTPS Config Server</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; padding: 2rem; max-width: 600px; }
        .url { background: #f5f5f5; padding: 0.5rem; border-radius: 4px; font-family: monospace; }
        .status { color: #28a745; font-weight: bold; }
        .warning { color: #ffc107; font-weight: bold; }
    </style>
</head>
<body>
    <h1>🔒 SurfingKeys HTTPS Config Server</h1>
    <p class="status">✅ HTTPS Server running on port ${PORT}</p>
    <p class="warning">⚠️ Using self-signed certificate - you'll need to accept the security warning</p>

    <h2>Access URLs:</h2>
    <p><strong>Local:</strong><br>
    <code class="url">https://localhost:${PORT}/surfingkeys</code></p>

    <p><strong>Network:</strong><br>
    <code class="url">https://${localIP}:${PORT}/surfingkeys</code></p>

    <h2>How to use:</h2>
    <ol>
        <li>Visit the URL above first to accept the security certificate</li>
        <li>Install SurfingKeys browser extension</li>
        <li>Go to SurfingKeys settings</li>
        <li>Set "Load settings from" to one of the HTTPS URLs above</li>
        <li>Save and reload any page to test</li>
    </ol>

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
    console.log('\n🔒 SurfingKeys HTTPS Config Server Started!');
    console.log('='.repeat(55));
    console.log(`📍 Local:   https://localhost:${PORT}/surfingkeys`);
    console.log(`🌐 Network: https://${localIP}:${PORT}/surfingkeys`);
    console.log(`📊 Status:  https://${localIP}:${PORT}/status`);
    console.log('='.repeat(55));
    console.log('⚠️  You will need to accept the self-signed certificate');
    console.log('Press Ctrl+C to stop the server\n');
});

// Graceful shutdown
process.on('SIGINT', () => {
    console.log('\n👋 Shutting down HTTPS SurfingKeys server...');
    server.close(() => {
        console.log('HTTPS Server stopped');
        process.exit(0);
    });
});