#!/usr/bin/bash

# Have Claude generate a script that displays the following in the status line
# - context usage as a fraction of the total context window (example: <TOKENS_USED> / <CONTEXT_WINDOW_SIZE>)
# - the current working directory
# - the current branch
# - cost of the current session

# Claude Code pipes session JSON on stdin. Pull out the fields we need as one
# tab-separated line: tokens used, context window size, cwd, cost (USD).
input=$(cat)

if command -v jq >/dev/null 2>&1; then
  fields=$(jq -r '
    (.context_window.current_usage // {}) as $u
    | [
        (($u.input_tokens // 0) + ($u.cache_creation_input_tokens // 0) + ($u.cache_read_input_tokens // 0)),
        (.context_window.context_window_size // 0),
        (.workspace.current_dir // .cwd // ""),
        (.cost.total_cost_usd // 0)
      ] | @tsv' <<<"$input")
else
  fields=$(python3 -c '
import json, sys
d = json.load(sys.stdin)
cw = d.get("context_window") or {}
u = cw.get("current_usage") or {}
used = sum(u.get(k) or 0 for k in ("input_tokens", "cache_creation_input_tokens", "cache_read_input_tokens"))
cwd = (d.get("workspace") or {}).get("current_dir") or d.get("cwd") or ""
cost = (d.get("cost") or {}).get("total_cost_usd") or 0
print(used, cw.get("context_window_size") or 0, cwd, cost, sep="\t")
' <<<"$input")
fi

IFS=$'\t' read -r used size cwd cost <<<"$fields"

# Thousands separators for the token counts, e.g. 45,210 / 200,000
used_fmt=$(printf "%'d" "$used" 2>/dev/null || echo "$used")
size_fmt=$(printf "%'d" "$size" 2>/dev/null || echo "$size")

# Show ~ instead of the full home path
dir=${cwd/#$HOME/\~}

branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
[ -z "$branch" ] && branch=$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null)

line="${used_fmt} / ${size_fmt} | ${dir}"
[ -n "$branch" ] && line+=" | ${branch}"
line+=$(printf ' | $%.2f' "$cost")

echo "$line"
