# claude-github-demo

A demonstration repo for running Claude Code as an automated PR review agent using the GitHub MCP server.

## Quick Start

```bash
# 1. Install dependencies
npm install

# 2. Export your GitHub token
export GITHUB_TOKEN=your_token_here

# 3. Run the review agent against all open PRs
./scripts/review-agent.sh
```

## Project Layout

```
.
├── CLAUDE.md                  # Agent instructions for Claude Code
├── .claude/
│   ├── mcp.json               # GitHub MCP server config
│   └── settings.json          # Claude Code permissions
├── scripts/
│   ├── setup.sh               # One-time environment setup
│   ├── create-demo-prs.sh     # Seed 4 demo pull requests
│   └── review-agent.sh        # Run Claude PR review agent
├── src/
│   ├── calculator.js          # Sample source module
│   └── calculator.test.js     # Jest tests
├── .github/workflows/ci.yml   # GitHub Actions CI
└── package.json
```

## How It Works

1. `review-agent.sh` launches Claude Code with `--mcp-config .claude/mcp.json`
2. Claude reads `CLAUDE.md` for review criteria
3. The GitHub MCP server lets Claude call `list_pull_requests`, `get_pull_request_diff`, and `create_review`
4. Claude posts structured review comments directly on each PR

## Demo PRs

Run `./scripts/create-demo-prs.sh` to create four branches with intentional issues:

| Branch | Issue seeded |
|--------|-------------|
| `feature/add-modulo` | Missing test coverage |
| `feature/sqrt-negative` | No error handling for negative input |
| `feature/hardcoded-secret` | Hardcoded API key (security) |
| `feature/fix-divide` | Actually introduces a regression |

## Requirements

- Node.js 18+
- Claude Code CLI (`npm install -g @anthropic-ai/claude-code`)
- `gh` CLI (for `create-demo-prs.sh`)
- `GITHUB_TOKEN` with `repo` scope
