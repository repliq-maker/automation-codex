# Automation Codex

Automation Codex is a Codex plugin marketplace for practical automation workflows.

## Install In Codex

Use Codex's **Add marketplace** flow and paste this GitHub URL:

```text
https://github.com/repliq-maker/Linkedin_posts_comments
```

Marketplace metadata:

```json
{
  "name": "automation-codex",
  "interface": {
    "displayName": "Automation Codex maker Plugins"
  }
}
```

## Available Plugins

### LinkedIn Posts Comments

Path:

```text
plugins/linkedin-posts-comments
```

This plugin researches LinkedIn posts from simple daily instructions, generates five comment options per scraped post, marks low-quality posts as irrelevant, and appends rows to a Google Sheet.

Daily automation format:

```text
Sheet folder: Codex_Automation
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
KEYWORDS: linkedin outreach / ai sdr / cold outreach / reply rate
Filter By: Past Week
Number of posts: 25
Apify key: YOUR_APIFY_KEY
```

## Repository Structure

- `.agents/plugins/marketplace.json` registers this repository as a Codex marketplace.
- `plugins/linkedin-posts-comments/.codex-plugin/plugin.json` registers the first plugin.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/SKILL.md` contains the plugin workflow.
- `plugins/linkedin-posts-comments/DAILY_AUTOMATION_GUIDE.md` has the copy/paste daily setup.

## Security

Never commit real API keys. All public examples must use placeholders such as `YOUR_APIFY_KEY`.
