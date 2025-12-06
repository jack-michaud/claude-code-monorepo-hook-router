#!/bin/bash

# Router hook wrapper for ui - calls existing prettier script
# Pipes stdin (JSON hook data) to the prettier script
# Changes to ui directory in case prettier needs to find config files

cd "$CLAUDE_PROJECT_DIR/ui" && cat | "$CLAUDE_PROJECT_DIR"/ui/.claude/scripts/prettier-hook.sh
