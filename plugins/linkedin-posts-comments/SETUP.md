# Setup Guide

Use this guide before sharing or running the plugin.

For a guided one-shot setup chat, copy `SETUP_AGENT_PROMPT.md` into a new private Codex chat. It checks installation, MCP setup, Google Drive, and the destination spreadsheet.

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

After adding the marketplace, install or enable `LinkedIn Posts Comments` from the marketplace list. The marketplace entry points to this plugin folder inside the same repository.

To invoke it in a new chat or daily automation, start with:

```text
Use $linkedin-posts-comments with this setup:
```

Slash commands and `@LinkedIn Posts Comments` mentions may not appear for skill-only plugins in every Codex UI.

## 2. Connect Google Drive

The setup agent should connect Google Drive, create the spreadsheet, create the tab, and add headers whenever Codex exposes the required tools. It should use the folder when folder tools are available, but folder placement is optional/manual when the connector can create/edit Sheets but cannot create folders or move files. The user should only need to approve Google Drive sign-in or connector installation when Codex asks for consent.

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

```json
{
  "mcpServers": {
    "apify-linkedin-post": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote",
        "https://mcp.apify.com/?tools=actors,docs,runs,apify/rag-web-browser",
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
- If the actor fails, confirm the actor supports the expected input fields.
- If Google Sheets cannot be found, confirm the spreadsheet name is exact. If the connector cannot create folders or move files, use the Sheet in the default/root Drive location and optionally move it manually in the Google Drive UI.
- If rows append to the wrong tab, provide `Sheet tab`.
- If too many posts are marked irrelevant, confirm the keywords are sales/outreach-specific, use `Past Month`, and then adjust the threshold fields if needed.
- If the run appends fewer rows than requested, increase `maxAgents` or confirm the scraper returns enough posts for the supplied keywords.
