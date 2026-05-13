# Production Checklist

Use this before sharing the plugin repository with the community.

## Required Checks

- `plugin.json` validates as JSON.
- `examples/daily-automation-payload.json` validates as JSON.
- `schemas/input.example.json` validates as JSON.
- `schemas/worker-output.example.json` validates as JSON.
- `mcp.example.json` validates as JSON.
- No real Apify token is present in the plugin folder.
- `.agents/plugins/marketplace.json` is committed at the repository root.
- `plugins/linkedin-posts-comments/.codex-plugin/plugin.json` is committed.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/SKILL.md` is committed.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/agents/openai.yaml` is committed.
- The daily prompt tells users to invoke `$linkedin-posts-comments`.
- Google Drive connector is connected.
- Apify key setup flow is tested through `SETUP_AGENT_PROMPT.md`, including private MCP setup when the MCP server is missing.
- The selected LinkedIn scraper accepts the expected input fields.
- A real dry run appends rows to the intended Google Sheet.
- At least one row reaches `reviewed`.
- At least one low-quality row is marked `irrelevant`.
- Hiring, operations, security/governance, generic AI, and motivational posts are marked `irrelevant`.
- Default daily setup uses `Past Month`.
- Duplicate post URLs are not appended twice.
- `Number of posts` produces a reasonable number of worker agents.
- `maxAgents` prevents runaway Apify usage.

## GitHub Release

Confirm the public repository contains only source/plugin files, no generated archives or private setup files.

Repository URL:

```text
https://github.com/repliq-maker/automation-codex
```

## Community Release Notes

Tell users:

- They need their own Apify account and token.
- They need Google Drive connected in Codex.
- They should replace all placeholder values in the daily payload.
- They should never post their token publicly.
- They can adjust traction thresholds if their niche has different engagement levels.
- They can adjust `Number of posts` to control volume and Apify usage.
