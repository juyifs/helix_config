#!/usr/bin/env bash
file=".helix/.session"
args=()
while IFS= read -r line || [ -n "$line" ]; do
  [ -z "$line" ] && continue
  args+=("$line")
done < "$file"
hx "${args[@]}"
