#!/usr/bin/env bash
set -euo pipefail

echo "==> Checking prerequisites..."

command -v node >/dev/null 2>&1 || { echo "ERROR: node not found. Install Node.js 18+."; exit 1; }
command -v npm  >/dev/null 2>&1 || { echo "ERROR: npm not found."; exit 1; }
command -v gh   >/dev/null 2>&1 || { echo "ERROR: gh CLI not found. Install from https://cli.github.com"; exit 1; }
command -v claude >/dev/null 2>&1 || { echo "ERROR: claude CLI not found. Run: npm install -g @anthropic-ai/claude-code"; exit 1; }

[[ -z "${GITHUB_TOKEN:-}" ]] && { echo "ERROR: GITHUB_TOKEN is not set. Export it before running."; exit 1; }

echo "==> Installing npm dependencies..."
npm install

echo "==> Verifying GitHub auth..."
gh auth status 2>/dev/null || gh auth login --with-token <<<"$GITHUB_TOKEN"

echo ""
echo "Setup complete. You can now run:"
echo "  ./scripts/create-demo-prs.sh   # seed demo PRs"
echo "  ./scripts/review-agent.sh      # run the review agent"
