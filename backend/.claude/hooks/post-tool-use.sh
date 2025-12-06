#!/bin/bash

# Router hook wrapper for backend - calls existing format script
# Pipes stdin (JSON hook data) to the format script
# Changes to backend directory so make format can find the Makefile

cd "$CLAUDE_PROJECT_DIR/backend" && cat | "$CLAUDE_PROJECT_DIR"/backend/.claude/scripts/ruff-hook.sh
