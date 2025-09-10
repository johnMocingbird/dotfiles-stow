import json
from mitmproxy import http as mitmhttp

CONSOLE_LOG_FILE = "/tmp/frontend-dev-logs/console.log"
POST_BODY_LOG_FILE = "/tmp/frontend-dev-logs/post-request-body.log"
POST_RESPONSE_LOG_FILE = "/tmp/frontend-dev-logs/post-request-response.log"
PUT_BODY_LOG_FILE = "/tmp/frontend-dev-logs/put-request-body.log"
PUT_RESPONSE_LOG_FILE = "/tmp/frontend-dev-logs/put-request-response.log"
GET_RESPONSE_LOG_FILE = "/tmp/frontend-dev-logs/get-request-response.log"

# The JavaScript to be injected
js_code = """
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
"""

def request(flow: mitmhttp.HTTPFlow) -> None:
    # Handle CORS preflight requests for the console logger
    if flow.request.method == "OPTIONS" and flow.request.pretty_url.endswith("/log"):
        flow.response = mitmhttp.Response.make(200, b"", {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "POST, OPTIONS",
            "Access-Control-Allow-Headers": "Content-Type",
        })
        return

    # Handle the actual console log request
    if flow.request.method == "POST" and flow.request.pretty_url.endswith("/log"):
        try:
            data = json.loads(flow.request.get_text())
            with open(CONSOLE_LOG_FILE, "a") as f:
                f.write(f"{data.get('message', '')}\n")
            flow.response = mitmhttp.Response.make(200, b"OK", {
                "Access-Control-Allow-Origin": "*"
            })
        except json.JSONDecodeError:
            flow.response = mitmhttp.Response.make(400, b"Invalid JSON", {
                "Access-Control-Allow-Origin": "*"
            })
        return

def response(flow: mitmhttp.HTTPFlow) -> None:
    # Inject the logger script into HTML responses
    if flow.response and flow.response.headers.get("content-type", "").startswith("text/html"):
        html = flow.response.get_text()
        html = html.replace("</head>", f"<script>{js_code}</script></head>")
        flow.response.set_text(html)

    # Log POST requests
    if flow.request.method == "POST" and flow.request.host == "localhost" and flow.request.port in [3000, 4200] and not flow.request.pretty_url.endswith("/log"):
        with open(POST_BODY_LOG_FILE, "a") as f:
            try:
                data = json.loads(flow.request.get_text())
                f.write(json.dumps(data, indent=2) + "\n")
            except json.JSONDecodeError:
                f.write(flow.request.get_text() + "\n")
        with open(POST_RESPONSE_LOG_FILE, "a") as f:
            try:
                data = json.loads(flow.response.get_text())
                f.write(json.dumps(data, indent=2) + "\n")
            except json.JSONDecodeError:
                f.write(flow.response.get_text() + "\n")

    # Log PUT requests
    if flow.request.method == "PUT" and flow.request.host == "localhost" and flow.request.port in [3000, 4200]:
        with open(PUT_BODY_LOG_FILE, "a") as f:
            try:
                data = json.loads(flow.request.get_text())
                f.write(json.dumps(data, indent=2) + "\n")
            except json.JSONDecodeError:
                f.write(flow.request.get_text() + "\n")
        with open(PUT_RESPONSE_LOG_FILE, "a") as f:
            try:
                data = json.loads(flow.response.get_text())
                f.write(json.dumps(data, indent=2) + "\n")
            except json.JSONDecodeError:
                f.write(flow.response.get_text() + "\n")

    # Log GET requests
    if flow.request.method == "GET" and flow.request.host == "localhost" and flow.request.port in [3000, 4200]:
        with open(GET_RESPONSE_LOG_FILE, "a") as f:
            try:
                data = json.loads(flow.response.get_text())
                f.write(json.dumps(data, indent=2) + "\n")
            except json.JSONDecodeError:
                f.write(flow.response.get_text() + "\n")