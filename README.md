# Automation Codex

Automation Codex is a Codex plugin marketplace for practical automation workflows.

## Install In Codex

Use Codex's **Add marketplace** flow and paste this GitHub URL:

```text
https://github.com/repliq-maker/automation-codex
```

Marketplace metadata:

```json
{
  "name": "automation-codex",
  "interface": {
    "displayName": "Automation Codex Maker Plugins"
  }
}
```

The marketplace entry uses a Git-backed subdirectory source so external Codex installs can fetch the plugin package from `plugins/linkedin-posts-comments`.

## Available Plugins

### LinkedIn Posts Comments

Path:

```text
plugins/linkedin-posts-comments
```

This plugin researches LinkedIn posts from simple daily instructions, generates five comment options per scraped post, marks low-quality posts as irrelevant, and appends rows to a Google Sheet.

After installing the plugin, start a chat or daily automation with:

```text
Use $linkedin-posts-comments with this setup:
```

Codex skill plugins may not appear as `@LinkedIn Posts Comments` mentions or slash commands in every UI. The reliable trigger is `$linkedin-posts-comments` or a natural-language request that names the LinkedIn Posts Comments plugin.

Daily automation format:

```text
Use $linkedin-posts-comments with this setup:
Sheet folder: Codex_Automation
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
KEYWORDS: linkedin outreach / cold outreach / ai sdr / outbound sales / sales automation / reply rate / prospecting
Filter By: Past Month
Number of posts: 25
Apify key: YOUR_APIFY_KEY
```

## Repository Structure

- `.agents/plugins/marketplace.json` registers this repository as a Codex marketplace.
- `plugins/linkedin-posts-comments/.codex-plugin/plugin.json` registers the first plugin package.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/SKILL.md` contains the plugin workflow.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/agents/openai.yaml` improves skill discovery and default prompt metadata.
- `plugins/linkedin-posts-comments/DAILY_AUTOMATION_GUIDE.md` has the copy/paste daily setup.

## Security

Never commit real API keys. All public examples must use placeholders such as `YOUR_APIFY_KEY`.
