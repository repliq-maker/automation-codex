# Production Checklist

Use this before sharing the marketplace with the community.

## Marketplace Checks

- `.agents/plugins/marketplace.json` validates as JSON.
- Marketplace name is `automation-codex`.
- Marketplace display name is `Automation Codex maker Plugins`.
- Each plugin entry has `name`, `source`, `policy`, and `category`.
- Each plugin path points to a real folder under `plugins/`.
- No real API keys are present in the repository.

## LinkedIn Posts Comments Checks

- `plugins/linkedin-posts-comments/.codex-plugin/plugin.json` validates as JSON.
- `plugins/linkedin-posts-comments/examples/daily-automation-payload.json` validates as JSON.
- `plugins/linkedin-posts-comments/schemas/input.example.json` validates as JSON.
- `plugins/linkedin-posts-comments/schemas/worker-output.example.json` validates as JSON.
- `plugins/linkedin-posts-comments/mcp.example.json` validates as JSON.
- A real dry run appends rows to the intended Google Sheet.
- Duplicate post URLs are not appended twice.

## Community Release Notes

Tell users:

- Add the GitHub URL as a Codex marketplace.
- Install or enable the plugin they want.
- Use each plugin's own setup guide.
- Never post API keys publicly.
