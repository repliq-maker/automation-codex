# Setup Guide

Use this guide before sharing or running the plugin.

For a guided one-shot setup chat, copy `SETUP_AGENT_PROMPT.md` into a new private Codex chat. It checks installation, MCP setup, Google Drive, and the destination spreadsheet.

The setup prompt is designed to act by default. It should not ask chat-permission before obvious setup steps such as marketplace install/upgrade, plugin enablement, MCP configuration, official Google Drive plugin setup, or Sheet/header creation. The only normal conversational question is the Apify key when missing. External platform approvals, sandbox approvals, and Google OAuth consent can still appear as required UI flows; those cannot be bypassed by the prompt.

## 1. Install The Plugin

Add the public GitHub repository as a Codex marketplace:

```text
https://github.com/repliq-maker/automation-codex
```

If needed, use the Git URL:

```text
https://github.com/repliq-maker/automation-codex.git
```

Use branch/ref:

```text
main
```

If Codex asks for partial paths or sparse checkout paths, include:

```text
.agents/plugins
plugins/linkedin-posts-comments
```

Do not use the raw `marketplace.json` URL as the marketplace source. Codex expects a Git marketplace source such as `owner/repo` or a Git URL.

The repository contains:

- Marketplace manifest: `.agents/plugins/marketplace.json`
- Plugin package: `plugins/linkedin-posts-comments`

After adding the marketplace, the setup agent must confirm `LinkedIn Posts Comments` is installed/enabled from that marketplace. The marketplace entry points to this plugin folder inside the same repository and is marked `INSTALLED_BY_DEFAULT`, but marketplace-added, cache presence, or default-install policy is not enough on its own.

The setup agent must also verify the local plugin cache. A green install check requires:

- Marketplace source configured.
- Plugin enabled in Codex config or UI.
- Plugin cache contains `.codex-plugin/plugin.json`.
- Plugin cache contains `skills/linkedin-posts-comments/SKILL.md`.
- Cached plugin version is current enough for this setup prompt.

The expected private plugin config entry is:

```toml
[plugins."linkedin-posts-comments@automation-codex"]
enabled = true
```

The setup agent should prefer Codex plugin install/enable UI or tool actions. It should not ask chat-permission before starting those required setup actions. It should not assume a general `codex plugin add` command exists; many Codex builds only expose marketplace commands. If no plugin install command is available but private config is writable, it can add or update that exact private config entry after making a backup. If the marketplace is present but this plugin entry is missing, the setup agent should enable the plugin before asking for a restart.

To invoke it in a new chat or daily automation, start with:

```text
Use $linkedin-posts-comments with this setup:
```

Slash commands and `@LinkedIn Posts Comments` mentions may not appear for skill-only plugins in every Codex UI.

If the marketplace was already installed, the setup agent should update it directly when the CLI/tool surface is available:

```text
codex plugin marketplace upgrade automation-codex
```

Only ask the user to run that command manually if the setup agent cannot run it because the command is unavailable, permissions are denied, the user must approve the action outside the chat, or Codex reports that the plugin cache cannot be refreshed.

If `codex plugin marketplace upgrade automation-codex` fails with a message such as `failed to refresh installed plugin cache`, `failed to back up plugin cache entry`, `Access is denied`, or `os error 5`, the plugin cache is probably locked by the running Codex process. The setup agent should wait briefly and retry the upgrade once. If it still fails, it should not mark the marketplace/plugin cache green and should not keep sending the user through another normal restart loop. Instead, tell the user to fully quit Codex, open an external terminal or PowerShell outside Codex, and run:

```text
codex plugin marketplace upgrade automation-codex
```

If that still fails after Codex is fully closed, rename only the stale plugin cache folder and run the upgrade again:

```powershell
$cache = Join-Path $env:USERPROFILE ".codex\plugins\cache\automation-codex\linkedin-posts-comments"
Rename-Item -LiteralPath $cache -NewName ("linkedin-posts-comments.bak-" + (Get-Date -Format "yyyyMMdd-HHmmss"))
codex plugin marketplace upgrade automation-codex
```

Then fully quit/reopen Codex and open a new chat. Skill plugins and MCP servers are loaded when a chat starts, so a setup chat can save the marketplace/MCP config while the current chat still cannot see the new skill or Apify tools.

Use the same setup prompt again after the restart. The first pass installs or connects all tools before one global restart. The second pass verifies the loaded skill/tools and creates or verifies the Sheet, tab, and headers. Do not run the daily automation until the second pass says `READY TO RUN`.

The setup agent should only ask for a restart when that setup pass actually installed, upgraded, enabled, connected, authenticated, or changed something. If nothing changed and a required skill/tool is still missing, it should retry transient checks first, then show the exact blocker in red instead of repeating the same restart instruction.

## 2. Connect Google Drive

The setup agent should use the official Codex Google Drive plugin/connector, not a Google Drive MCP server. It should connect Google Drive, create the spreadsheet, create the tab, and add headers whenever Codex exposes the required tools. It should use the folder when folder tools are available, but folder placement is optional/manual when the connector can create/edit Sheets but cannot create folders or move files. It should start official Google Drive install/connect flows directly when available. The user should only need to approve Google Drive sign-in or connector installation when Codex or Google shows an external consent UI.

Auto review can approve Codex-side setup actions, but it cannot silently complete external Google OAuth consent or repair a broken Google Drive refresh token. If Google Drive returns an auth error such as `access token could not be refreshed`, `refresh token was already used`, `invalid_grant`, `token expired`, `token revoked`, or `please log out and sign in again`, the user must disconnect/log out of Google Drive in Codex, reconnect/sign in again, then rerun the setup prompt.

If the official Google Drive plugin is installed but disabled and private config is writable, the setup agent can enable this official plugin entry:

```toml
[plugins."google-drive@openai-curated"]
enabled = true
```

The default setup target is:

- Spreadsheet file, for example `Comments_Linkedin_Post`.
- Sheet tab, usually `Comments`.

`Sheet folder` is optional and is not needed by default. Add it only when the user wants to target a specific existing folder and the connector supports folder-scoped search or placement.

The tab should have these headers in row 1:

```text
Post linkedin
Authors
Comments
Likes
keywords
Comment 1
Comment 2
Comment 3
Comment 4
Comment 5
Status
```

## 3. Configure Apify MCP

The user only needs to paste their Apify key during the private setup prompt. Daily or weekly run prompts should not include the key after `apify-linkedin-post` is configured. The plugin uses `apify-linkedin-post` internally as the MCP server name.

Do not collect keywords, date filter, or post volume during setup. `KEYWORDS`, `Filter By`, and `Number of posts` belong in each run prompt. The setup Sheet file/tab can create a convenient default Sheet, but any run prompt may provide different Sheet fields and the plugin should use the values from that current run. If no folder is provided or folder placement is unavailable, create or use the Sheet in the connector's default/root Drive location.

If the user does not already have an Apify key:

1. Go to the Apify dashboard: https://console.apify.com/
2. Click Settings -> API & Integrations -> Create a new token.
3. Use a description like `Skool outreach Codex Automation Apify Key`.
4. Click Create.
5. Find the token under Personal API tokens, click the Copy icon, and paste it only in the private Codex setup chat.

If the MCP server does not exist yet, the plugin should generate setup guidance from the user's Apify key. The same template is available in `mcp.example.json` for advanced users. Replace `YOUR_APIFY_KEY` with the user's own token.

When available, the setup agent should use:

```text
codex mcp add apify-linkedin-post -- npx -y mcp-remote "https://mcp.apify.com/?tools=actors,docs,runs,harvestapi/linkedin-post-search" --header "Authorization: Bearer YOUR_APIFY_KEY"
```

After adding or changing this MCP server, fully quit/reopen Codex and open a new chat before running the automation. Seeing the server in settings confirms it is saved; the run chat also needs Apify tools to be visible/callable.

Before telling the user that Apify MCP is not working, the setup agent should retry transient MCP checks. If the MCP server is already saved but tools are not visible or do not answer, wait about 10 seconds, retry; wait about 20 seconds, retry and re-run tool discovery if available; wait about 30 seconds, retry a final lightweight Apify capability check. Do not run the full LinkedIn scraper just to test setup. Only ask the user for action after those retries fail.

If the setup prompt adds or changes the MCP server, marketplace/plugin, or Google Drive connector, it should finish the full bootstrap sweep, stop before Sheet creation, ask for a full Codex restart/new chat, and ask the user to paste the same setup prompt again. Sheet creation belongs in the second pass after all tools are loaded.

```json
{
  "mcpServers": {
    "apify-linkedin-post": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote",
        "https://mcp.apify.com/?tools=actors,docs,runs,harvestapi/linkedin-post-search",
        "--header",
        "Authorization: Bearer YOUR_APIFY_KEY"
      ]
    }
  }
}
```

Never share a real Apify API token in the GitHub repository, course material, screenshots, videos, or community comments. Users should replace `YOUR_APIFY_KEY` only inside their private Codex setup chat.

## 4. LinkedIn Post Scraper

By default, the plugin should resolve a LinkedIn post scraper actor through Apify.

The scraper should support this input body:

```json
{
  "maxPosts": 5,
  "maxReactions": 5,
  "postNestedComments": false,
  "postNestedReactions": false,
  "postedLimit": "month",
  "scrapeComments": false,
  "scrapeReactions": false,
  "searchQueries": ["linkedin outreach"],
  "sortBy": "relevance"
}
```

## 5. Daily Automation Prompt

Paste this into the daily automation setup and replace the values:

```text
Use $linkedin-posts-comments with this setup:
Optional Sheet folder: My Existing Folder
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
KEYWORDS: linkedin outreach / cold outreach / ai sdr / outbound sales / sales automation / reply rate / prospecting
Filter By: Past Month
Number of posts: 25
```

For the simplest recurring prompt, use `DAILY_AUTOMATION_GUIDE.md`.

## 6. Troubleshooting

- If Apify cannot run, confirm the Apify key is valid and the private MCP setup was added correctly.
- If Apify tools are slow to appear or answer, retry the setup prompt check after short waits before asking the user for action; the setup agent should use the retry ladder in `SETUP_AGENT_PROMPT.md`.
- If a run chat says it cannot find the `linkedin-posts-comments` skill, rerun the setup prompt. The setup agent should verify that `[plugins."linkedin-posts-comments@automation-codex"]` is enabled, verify that the plugin cache contains the current package and skill file, enable it when possible, and upgrade the marketplace directly when needed. It should only ask for a restart if it actually changed the install/config state during that pass.
- If marketplace upgrade fails with access denied while refreshing plugin cache, fully quit Codex and run the marketplace upgrade from an external terminal. If needed, rename only the stale cache folder shown above, then rerun the upgrade.
- If setup says the Apify MCP server is saved but tools are not visible, restart Codex and open a new chat before running.
- If Google Drive says the access token could not be refreshed or asks the user to log out and sign in again, reconnect Google Drive in Codex and rerun setup. This is an external OAuth issue, not something auto review can approve.
- If the actor fails, confirm the actor supports the expected input fields.
- If Google Sheets cannot be found, confirm the spreadsheet name is exact. If the connector cannot create folders or move files, use the Sheet in the default/root Drive location and optionally move it manually in the Google Drive UI.
- If rows append to the wrong tab, provide `Sheet tab`.
- If too many posts are marked irrelevant, confirm the keywords are sales/outreach-specific, use `Past Month`, and then adjust the threshold fields if needed.
- If the run appends fewer rows than requested, increase `maxAgents` or confirm the scraper returns enough posts for the supplied keywords.
