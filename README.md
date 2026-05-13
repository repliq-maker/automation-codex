# Automation Codex

Automation Codex is a Codex plugin marketplace for practical automation workflows.

## Install In Codex

Use Codex's **Add marketplace** flow and paste this GitHub URL:

```text
https://github.com/repliq-maker/automation-codex
```

Branch/ref:

```text
main
```

If Codex asks for partial paths or sparse checkout paths, include:

```text
.agents/plugins
plugins/linkedin-posts-comments
```

Do not paste the raw `marketplace.json` URL as the marketplace source. Use the repo URL or Git URL.

Marketplace metadata:

```json
{
  "name": "automation-codex",
  "interface": {
    "displayName": "Automation Codex Maker Plugins"
  }
}
```

The marketplace entry uses a same-repo local source so Codex loads the plugin package from `plugins/linkedin-posts-comments` after cloning the marketplace repository.

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

For first-time setup, use:

```text
plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md
```

That prompt checks the marketplace, plugin, Apify MCP server, Google Drive connection, spreadsheet, tab, and headers. It uses a Drive folder when available, but can continue with a Sheet in the default/root Drive location when folder-create or file-move actions are unavailable. Do not paste real Apify keys into screenshots, community posts, or videos; users should replace `YOUR_APIFY_KEY` only inside their private Codex setup chat.

Daily automation format:

```text
Use $linkedin-posts-comments with this setup:
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
KEYWORDS: linkedin outreach / cold outreach / ai sdr / outbound sales / sales automation / reply rate / prospecting
Filter By: Past Month
Number of posts: 25
```

After setup, users do not need to mention Google Drive or include their Apify key in normal runs. The Sheet fields tell the plugin where to write, and the setup prompt configures the private Apify MCP server once.

`Sheet folder` is optional and is not needed by default. Add it only when targeting a specific existing folder. If the Google Drive connector cannot create folders or move files, the automation can still write to the named Sheet file in the default/root Drive location.

## Repository Structure

- `.agents/plugins/marketplace.json` registers this repository as a Codex marketplace.
- `plugins/linkedin-posts-comments/.codex-plugin/plugin.json` registers the first plugin package.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/SKILL.md` contains the plugin workflow.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/agents/openai.yaml` improves skill discovery and default prompt metadata.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` has the copy/paste setup agent and readiness checklist.
- `plugins/linkedin-posts-comments/DAILY_AUTOMATION_GUIDE.md` has the copy/paste daily setup.

## Security

Never commit real API keys. Public setup examples must use placeholders such as `YOUR_APIFY_KEY`, and run prompts should not include API keys after setup.
