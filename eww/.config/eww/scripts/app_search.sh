#!/bin/bash
query="${1,,}"  # lowercase query

find /usr/share/applications ~/.local/share/applications -name "*.desktop" 2>/dev/null | while read -r file; do
    name=$(grep -m1 '^Name=' "$file" | cut -d= -f2- | head -n 1)
    exec=$(grep -m1 '^Exec=' "$file" | cut -d= -f2- | sed 's/ .*$//' | head -n 1)

    # Skip if empty
    if [[ -n "$name" && -n "$exec" ]]; then
        # Escape double quotes
        name_escaped=$(printf '%s' "$name" | sed 's/"/\\"/g')
        exec_escaped=$(printf '%s' "$exec" | sed 's/"/\\"/g')
        echo "{\"name\": \"$name_escaped\", \"exec\": \"$exec_escaped\"}"
    fi
done | jq -s --arg q "$query" '[.[] | select(.name | ascii_downcase | test($q))]'
