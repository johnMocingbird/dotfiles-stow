#!/usr/bin/env python3
from flask import Flask, request
import json
import os

app = Flask(__name__)

LOG_DIR = "/tmp/frontend-dev-logs"

if not os.path.exists(LOG_DIR):
    os.makedirs(LOG_DIR)

@app.route('/log', methods=['POST'])
def log():
    data = request.get_json()
    log_type = data.get("type", "unknown")
    log_file_path = os.path.join(LOG_DIR, f"{log_type}.log")

    with open(log_file_path, "a") as f:
        f.write(json.dumps(data, indent=2))
        f.write("\n")

    return "OK"

if __name__ == '__main__':
    try:
        app.run(host='0.0.0.0', port=5001)
    except ImportError:
        print("Flask is not installed. Please install it with 'pip install flask'")
