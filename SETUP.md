# Setup Guide

## Add The Marketplace

In Codex, use **Add marketplace** and paste:

```text
https://github.com/repliq-maker/automation-codex
```

If the UI expects a Git URL, use:

```text
https://github.com/repliq-maker/automation-codex.git
```

Use branch/ref:

```text
main
```

If the UI asks for sparse checkout or partial paths, add both paths:

```text
.agents/plugins
plugins/linkedin-posts-comments
```

Do not use the `raw.githubusercontent.com/.../marketplace.json` URL as the marketplace source. Codex expects a Git marketplace source such as `owner/repo` or a Git URL.

Codex should read:

```text
.agents/plugins/marketplace.json
```

Then run the plugin setup prompt so Codex can install/enable the plugin and configure its required tools for the user.

For LinkedIn Posts Comments, paste this file into a private Codex chat:

```text
plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md
```

The setup prompt should add/upgrade the marketplace, enable `linkedin-posts-comments@automation-codex`, configure the private Apify MCP server, and install/connect the official Google Drive plugin/connector when Codex exposes those actions.

The setup prompt also verifies the plugin cache. If Codex reports that the marketplace upgrade failed while refreshing or backing up the plugin cache, follow the setup prompt's external-terminal recovery steps instead of repeating normal restarts.

If the setup prompt changes marketplace, plugin, MCP, or connector state, fully quit and reopen Codex. Then either type `continue` in the same setup chat or open a new chat and paste the same setup prompt again. The second pass verifies loaded tools and creates or checks the Sheet, tab, and headers. Do not run the daily automation until setup says `READY TO RUN`.

## Invoke A Plugin

For LinkedIn Posts Comments, use this at the top of a new chat or daily automation:

```text
Use $linkedin-posts-comments with this setup:
```

Do not rely on `/linkedin-posts-comments` or `@LinkedIn Posts Comments`; those may not be exposed for skill-only plugins in every Codex UI.

## First Plugin

The first plugin is:

```text
LinkedIn Posts Comments
```

Plugin package path:

```text
plugins/linkedin-posts-comments
```

See:

```text
plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md
plugins/linkedin-posts-comments/README.md
plugins/linkedin-posts-comments/DAILY_AUTOMATION_GUIDE.md
```

## User Requirements

For the LinkedIn plugin, each user needs:

- Google Drive connected in Codex.
- A Google Sheet with the required headers.
- An Apify account and private Apify key.
- A LinkedIn post scraper actor available through Apify.

The setup prompt creates or verifies the Google Sheet when Google Drive tools are available. Never share real Apify keys in GitHub, screenshots, videos, daily automation prompts, or community posts.
