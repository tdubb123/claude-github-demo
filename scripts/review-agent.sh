#!/usr/bin/env bash
set -euo pipefail

REPO="tdubb123/claude-github-demo"
MCP_CONFIG=".claude/mcp.json"

[[ -z "${GITHUB_TOKEN:-}" ]] && { echo "ERROR: GITHUB_TOKEN is not set."; exit 1; }
[[ ! -f "$MCP_CONFIG" ]] && { echo "ERROR: $MCP_CONFIG not found. Run from repo root."; exit 1; }

PR_NUMBER="${1:-}"

if [[ -n "$PR_NUMBER" ]]; then
  PROMPT="Review pull request #${PR_NUMBER} on ${REPO}.
Fetch the PR details and diff using the GitHub MCP tools.
Post a detailed review comment covering: correctness, security, test coverage, style, and PR hygiene.
If issues are found, request changes with specific inline comments. If the PR looks good, approve it."
else
  PROMPT="You are a PR review agent for ${REPO}.
1. List all open pull requests using the GitHub MCP tools.
2. For each open PR, fetch its diff and review it for: correctness, security, test coverage, style, and PR hygiene.
3. Post a structured review on each PR. Request changes with specific comments if issues exist; approve if it looks good.
Be thorough but concise. Group related issues. Always cite line numbers when commenting on code."
fi

echo "==> Launching Claude PR review agent..."
echo "    Repo:   $REPO"
echo "    PR:     ${PR_NUMBER:-all open}"
echo ""

claude \
  --mcp-config "$MCP_CONFIG" \
  --allowedTools "mcp__github__*" \
  -p "$PROMPT"
