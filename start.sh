#!/bin/bash
# AgentOS Mission Control — Launcher
cd "$(dirname "$0")"
echo "Starting AgentOS Mission Control on http://127.0.0.1:51763"
python3 server.py
