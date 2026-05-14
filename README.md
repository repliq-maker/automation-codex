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

For existing installs, the setup prompt updates the marketplace automatically when the CLI/tool surface is available. Manual fallback if the setup agent cannot run the command:

```text
codex plugin marketplace upgrade automation-codex
```

Fully quit and reopen Codex after installing/upgrading the marketplace, enabling the plugin, or adding the Apify MCP server. After reopening, users can return to the same setup chat and type `continue`. If that resumed chat still cannot see the new plugin skills or MCP tools but config/cache/MCP are correct, setup should create the Sheet anyway and report `SETUP SHEET READY, RUNTIME LOAD CHECK BLOCKED`; a new chat is only a one-time runtime diagnostic, not another setup loop.

The setup prompt is one prompt with two passes: first install/connect all needed tools, then fully quit and reopen Codex. For the second pass, type `continue` in the same setup chat or paste the setup prompt in a new chat to verify loaded tools and create the Sheet. The prompt is idempotent, so a new chat should detect already-correct marketplace/plugin/cache/MCP state and move forward instead of reinstalling tools or asking for another restart. If the custom skill or Apify tools still are not visible but config/cache/MCP are correct, setup should create the Sheet anyway and report `SETUP SHEET READY, RUNTIME LOAD CHECK BLOCKED` instead of looping through more new chats. That blocked-state output should include a small copy/paste runtime test prompt with cached-skill and Apify tool-discovery fallback instructions. Run automations only after the second pass says `READY TO RUN`.

If Codex Settings shows the plugin or MCP server as installed but a chat cannot see the skill or tools, the install layer is correct but the chat runtime did not inject those surfaces. Use the robust runtime prompt in `plugins/linkedin-posts-comments/DAILY_AUTOMATION_GUIDE.md` so the agent can read the cached skill file and try Apify tool discovery before declaring a runtime loading blocker.

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
Optional Sheet folder: My Existing Folder
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
KEYWORDS: linkedin outreach / cold outreach / ai sdr / outbound sales / sales automation / reply rate / prospecting
Filter By: Past Month
Number of posts: 25
```

After setup, users do not need to mention Google Drive or include their Apify key in normal runs. The Sheet fields tell the plugin where to write, and the setup prompt configures the private Apify MCP server once.

`Optional Sheet folder` can be deleted when not needed. Add it only when targeting a specific existing folder. If the Google Drive connector cannot create folders or move files, the automation can still write to the named Sheet file in the default/root Drive location.

## Repository Structure

- `.agents/plugins/marketplace.json` registers this repository as a Codex marketplace.
- `plugins/linkedin-posts-comments/.codex-plugin/plugin.json` registers the first plugin package.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/SKILL.md` contains the plugin workflow.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/agents/openai.yaml` improves skill discovery and default prompt metadata.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` has the copy/paste setup agent and readiness checklist.
- `plugins/linkedin-posts-comments/DAILY_AUTOMATION_GUIDE.md` has the copy/paste daily setup.

## Security

Never commit real API keys. Public setup examples must use placeholders such as `YOUR_APIFY_KEY`, and run prompts should not include API keys after setup.
