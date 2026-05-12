# Setup Guide

Use this guide before sharing or running the plugin.

## 1. Install The Plugin

Add the public GitHub repository as a Codex marketplace:

```text
https://github.com/repliq-maker/automation-codex
```

The repository contains:

- Marketplace manifest: `.agents/plugins/marketplace.json`
- Plugin package: `plugins/linkedin-posts-comments`

After adding the marketplace, install or enable `LinkedIn Posts Comments` from the marketplace list.

To invoke it in a new chat or daily automation, start with:

```text
Use $linkedin-posts-comments with this setup:
```

Slash commands and `@LinkedIn Posts Comments` mentions may not appear for skill-only plugins in every Codex UI.

## 2. Connect Google Drive

The user needs Google Drive access in Codex. They should create or identify:

- Google Drive folder, for example `Codex_Automation`.
- Spreadsheet file, for example `Comments_Linkedin_Post`.
- Sheet tab, usually `Comments`.

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

The user only needs to paste their Apify key in the daily setup. The plugin uses `apify-linkedin-post` internally as the MCP server name.

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

Never share a real Apify API token in the GitHub repository, course material, screenshots, or community comments.

## 4. LinkedIn Post Scraper

By default, the plugin should resolve a LinkedIn post scraper actor through Apify.

The scraper should support this input body:

```json
{
  "maxPosts": 5,
  "maxReactions": 5,
  "postNestedComments": false,
  "postNestedReactions": false,
  "postedLimit": "week",
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
Sheet folder: Codex_Automation
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
KEYWORDS: linkedin outreach / ai sdr / cold outreach / reply rate
Filter By: Past Week
Number of posts: 25
Apify key: YOUR_APIFY_KEY
```

For the simplest recurring prompt, use `DAILY_AUTOMATION_GUIDE.md`.

## 6. Troubleshooting

- If Apify cannot run, confirm the Apify key is valid and the private MCP setup was added correctly.
- If the actor fails, confirm the actor supports the expected input fields.
- If Google Sheets cannot be found, confirm the folder and spreadsheet names are exact.
- If rows append to the wrong tab, provide `Sheet tab`.
- If too many posts are marked irrelevant, adjust the threshold fields in the daily payload.
- If the run appends fewer rows than requested, increase `maxAgents` or confirm the scraper returns enough posts for the supplied keywords.
