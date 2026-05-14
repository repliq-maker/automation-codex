# Production Checklist

Use this before sharing the marketplace with the community.

## Marketplace Checks

- `.agents/plugins/marketplace.json` validates as JSON.
- Marketplace name is `automation-codex`.
- Marketplace display name is `Automation Codex Maker Plugins`.
- Each plugin entry has `name`, `source`, `policy`, and `category`.
- Marketplace plugin entries use `source: "local"` with a `./`-prefixed plugin path relative to the marketplace repository root.
- Each plugin path points to a real folder under `plugins/`.
- Public setup docs tell users to use branch/ref `main` and partial paths `.agents/plugins` plus `plugins/linkedin-posts-comments` when Codex asks for sparse paths.
- Public setup docs route users through each plugin's setup agent before daily automation use.
- Setup docs explain the one-prompt/two-pass flow and require a full quit/reopen/new chat after plugin or MCP changes.
- Setup docs distinguish marketplace-added from plugin-installed/enabled.
- No real API keys are present in the repository.

## LinkedIn Posts Comments Checks

- `plugins/linkedin-posts-comments/.codex-plugin/plugin.json` validates as JSON.
- `plugins/linkedin-posts-comments/examples/daily-automation-payload.json` validates as JSON.
- `plugins/linkedin-posts-comments/schemas/input.example.json` validates as JSON.
- `plugins/linkedin-posts-comments/schemas/worker-output.example.json` validates as JSON.
- `plugins/linkedin-posts-comments/mcp.example.json` validates as JSON.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` verifies/enables `linkedin-posts-comments@automation-codex`.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` verifies the local plugin cache and gives access-denied cache recovery steps.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` retries transient MCP and connector checks before asking users for action.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` tells users to reconnect Google Drive for refresh-token/OAuth failures.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` asks in chat only for the Apify key when it is missing.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` does not ask for a second chat approval to persist the provided Apify key in private MCP config.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` uses the direct Apify API-key MCP setup and does not switch users into Apify OAuth.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` configures Apify only with a private user key and does not put keys into daily prompts.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` uses the official Google Drive plugin/connector, not Google Drive MCP.
- A real dry run appends rows to the intended Google Sheet.
- Duplicate post URLs are not appended twice.

## Community Release Notes

Tell users:

- Add the GitHub URL as a Codex marketplace.
- Paste each plugin's setup prompt in a private Codex chat.
- Fully quit/reopen Codex and rerun setup when the setup checklist asks for it.
- Start daily runs only after setup says `READY TO RUN`.
- Never post API keys publicly.
