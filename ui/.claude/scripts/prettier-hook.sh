#!/bin/bash
# .claude/scripts/prettier-hook.sh
# Auto-format files with prettier after Edit or Write operations

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path')

# Only run on Edit and Write operations
if [[ "$TOOL_NAME" != "Edit" && "$TOOL_NAME" != "Write" ]]; then
  exit 0
fi

# Check if file path is valid
if [[ -z "$FILE_PATH" || "$FILE_PATH" == "null" ]]; then
  exit 0
fi

# Check if file exists
if [[ ! -f "$FILE_PATH" ]]; then
  exit 0
fi

# Get file extension
EXT="${FILE_PATH##*.}"

# Only format supported file types
case "$EXT" in
  js|jsx|ts|tsx|mjs|cjs|json|css|scss|html|md|yml|yaml)
    if bunx prettier --write "$FILE_PATH" 2>/dev/null; then
      echo "✅ Formatted with prettier: $FILE_PATH"
    else
      echo "⚠️  Prettier formatting failed for: $FILE_PATH"
    fi
    ;;
  *)
    # Not a supported file type, skip silently
    ;;
esac

exit 0  # Never block, just format if possible
