#!/bin/bash
# Post-edit hook that runs make format

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name')

if [[ "$TOOL_NAME" == "Edit" || "$TOOL_NAME" == "Write" ]]; then
  echo "🔧 Running make format..."
  if make format 2>&1; then
    echo "✅ Code formatted successfully"
  else
    echo "⚠️  Warning: make format encountered an issue"
  fi
fi

exit 0
