# Production Checklist

Use this before sharing the plugin zip with the community.

## Required Checks

- `plugin.json` validates as JSON.
- `examples/daily-automation-payload.json` validates as JSON.
- `schemas/input.example.json` validates as JSON.
- `schemas/worker-output.example.json` validates as JSON.
- `mcp.example.json` validates as JSON.
- No real Apify token is present in the plugin folder.
- `.codex-plugin/plugin.json` is included in the zip.
- Google Drive connector is connected.
- Apify key flow is tested, including private MCP setup guidance when the MCP server is missing.
- The selected LinkedIn scraper accepts the expected input fields.
- A real dry run appends rows to the intended Google Sheet.
- At least one row reaches `reviewed`.
- At least one low-quality row is marked `irrelevant`.
- Duplicate post URLs are not appended twice.
- `Number of posts` produces a reasonable number of worker agents.
- `maxAgents` prevents runaway Apify usage.

## Release Zip

Run:

```powershell
.\scripts\package-plugin.ps1
```

Expected output:

```text
dist/linkedin-posts-comments.zip
```

Open the zip and confirm it contains `.codex-plugin/plugin.json`.

## Community Release Notes

Tell users:

- They need their own Apify account and token.
- They need Google Drive connected in Codex.
- They should replace all placeholder values in the daily payload.
- They should never post their token publicly.
- They can adjust traction thresholds if their niche has different engagement levels.
- They can adjust `Number of posts` to control volume and Apify usage.
