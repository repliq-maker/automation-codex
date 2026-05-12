# Security

This plugin is designed to be shared without secrets.

## Do Not Share Secrets

Never include a real Apify API token in:

- the plugin zip.
- screenshots.
- Skool posts.
- setup videos.
- example payloads.
- GitHub commits.

Use `YOUR_APIFY_KEY` in public examples.

## If A Token Was Exposed

1. Revoke or rotate the token in Apify.
2. Replace the token in any private automation setup.
3. Search the plugin folder for the exact exposed token value before sharing:

```powershell
rg -n "paste-the-exposed-token-value-here" plugins\linkedin-posts-comments -u
```

## Private User Setup

Each user should create their own Apify token and add it only to their private Codex MCP setup or private daily automation instructions.

The plugin instructions tell Codex not to save real MCP credentials or API tokens into plugin files.
