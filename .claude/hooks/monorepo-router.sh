#!/bin/bash

# Monorepo Hook Router
# Automatically routes PostToolUse hooks to the appropriate subdirectory based on file path

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"

# Read the hook input JSON from stdin
INPUT=$(cat)

# Extract the file path from the JSON input
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# If no file path, exit silently
if [[ -z "$FILE_PATH" || "$FILE_PATH" == "null" ]]; then
  exit 0
fi

# Determine which subdirectory the file belongs to
if [[ "$FILE_PATH" == */backend/* ]]; then
  SUBDIR="backend"
elif [[ "$FILE_PATH" == */ui/* ]]; then
  SUBDIR="ui"
else
  # File is not in a managed subdirectory, exit silently
  exit 0
fi

# Check if subdirectory has a post-tool-use hook and execute it
HOOK_SCRIPT="$PROJECT_DIR/$SUBDIR/.claude/hooks/post-tool-use.sh"
if [[ -x "$HOOK_SCRIPT" ]]; then
  # Pass the JSON input to the subdirectory hook via stdin
  echo "$INPUT" | "$HOOK_SCRIPT"
fi
