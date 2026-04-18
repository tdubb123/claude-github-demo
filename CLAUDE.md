# PR Review Agent

This project uses Claude Code as an automated PR review agent via the GitHub MCP server.

## What This Agent Does

When triggered, the agent:
1. Fetches open pull requests from this repository
2. Reviews each PR's diff for code quality, bugs, and security issues
3. Posts structured review comments directly on the PR
4. Requests changes or approves based on findings

## Running the Agent

```bash
# Review all open PRs
./scripts/review-agent.sh

# Review a specific PR by number
./scripts/review-agent.sh 42
```

## MCP Server

This project uses the official `@modelcontextprotocol/server-github` MCP server.
Configuration is in `.claude/mcp.json`. The server requires a `GITHUB_TOKEN` environment variable
with `repo` scope.

## Review Criteria

The agent evaluates PRs on:
- **Correctness** — logic errors, off-by-one, unhandled edge cases
- **Security** — injection, hardcoded secrets, unsafe operations
- **Test coverage** — missing tests for new behavior
- **Style** — naming, unnecessary complexity, dead code
- **PR hygiene** — clear description, reasonable scope

## Repository

`tdubb123/claude-github-demo`
