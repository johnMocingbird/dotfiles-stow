

import json
import datetime
from mitmproxy import http as mitmhttp
from mitmproxy import ctx

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

def log_entry(file, data):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    line_break = "\n" + "="*20 + "\n"
    with open(file, "a") as f:
        f.write(f"{timestamp}{line_break}")
        try:
            parsed_data = json.loads(data)
            f.write(json.dumps(parsed_data, indent=2) + "\n")
        except json.JSONDecodeError:
            f.write(data + "\n")

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
    # Only process requests to our services
    if not (flow.request.host == "localhost" and flow.request.port in [3000, 4200]):
        return

    # Ignore sourcemap files
    if flow.request.pretty_url.endswith(".map"):
        return

    # Inject the logger script into HTML responses
    if flow.response and "text/html" in flow.response.headers.get("content-type", ""):
        try:
            flow.response.text = flow.response.text.replace("</head>", f"<script>{js_code}</script></head>")
        except ValueError:
            ctx.log.warn(f"Could not decode HTML response for {flow.request.pretty_url}")

    # Log POST requests
    if flow.request.method == "POST" and not flow.request.pretty_url.endswith("/log"):
        try:
            log_entry(POST_BODY_LOG_FILE, flow.request.text)
            log_entry(POST_RESPONSE_LOG_FILE, flow.response.text)
        except ValueError:
            ctx.log.warn(f"Could not decode POST request/response for {flow.request.pretty_url}")

    # Log PUT requests
    if flow.request.method == "PUT":
        try:
            log_entry(PUT_BODY_LOG_FILE, flow.request.text)
            log_entry(PUT_RESPONSE_LOG_FILE, flow.response.text)
        except ValueError:
            ctx.log.warn(f"Could not decode PUT request/response for {flow.request.pretty_url}")

    # Log GET requests
    if flow.request.method == "GET" and "application/json" in flow.response.headers.get("content-type", ""):
        try:
            log_entry(GET_RESPONSE_LOG_FILE, flow.response.text)
        except ValueError:
            ctx.log.warn(f"Could not decode GET response for {flow.request.pretty_url}")
