# Directory submissions: checklist and answers

How Portal Imobiliário was submitted to the OpenAI plugin directory (ChatGPT) and the Claude directory (MCP connector and plugin bundle). Reuse it as the template for other MCP servers. Credentials for the reviewers' test account are entered in the forms only, never in this repository.

## 1. Before any submission

- Remote MCP server over Streamable HTTP with OAuth 2.1 (PKCE, dynamic client registration and client ID metadata documents), discovery at `/.well-known/oauth-protected-resource` and `/.well-known/oauth-authorization-server`.
- One tool per operation. A tool with an `action` parameter, or one that does several things depending on its arguments, is refused: expose `list_x`, `add_x`, `delete_x`... each with its own schema.
- Every tool declares `readOnlyHint`, `destructiveHint` and `openWorldHint` explicitly:
  - `destructiveHint: true` for anything that deletes, overwrites existing data or is hard to undo: updates that replace fields, batch imports, creating with a reference that may exist, connecting a feed that replaces listings, publishing a reply that replaces a previous one.
  - `openWorldHint: true` for anything that downloads from URLs (photos, feeds) or publishes something the public sees (a listing, a page, a review reply) or other systems read (XML exports).
  - Read-only tools: `readOnlyHint: true`, the other two false.
- ChatGPT also expects `search` (free text, returns ids) and `fetch` (one id, returns the full text).
- Descriptions and listing texts without prices, plans, "free", trials or promotions.
- Never return third parties' personal contacts to the assistant.
- A test account for the reviewers that signs in with a password (no MFA, email codes or magic links), with sample data, and whose test emails go nowhere.
- Public pages: privacy policy (with a paragraph on AI assistants), terms, support contact, and a documentation page for the connector.

## 2. OpenAI (ChatGPT) plugin

Package: `./scripts/package.sh` builds `dist/portal-imobiliario-<version>.zip`, one `portal-imobiliario/` folder with only `plugin.json`, `mcp.json`, `LICENSE`, `skills/` and `assets/`. Bump `version` for every new upload.

`plugin.json` (`extensions.com.openai`):
- `interface`: displayName (30), shortDescription (30), longDescription (4000), developerName, category from the accepted list ("Developer Tools", "Communication", "Finance", "Productivity", "Data & Analytics", "Creativity", "Education & Research", "Business & Operations", "Travel"), capabilities, websiteURL, supportURL, privacyPolicyURL, termsOfServiceURL, up to 3 defaultPrompt (128), brandColor and brandColorDark (2:1 contrast against white and #212121), logo, composerIcon, screenshots.
- `review`: exactly 5 `test_cases.positive` (description, prompt, tools_triggered, expected_behavior) and 3 `test_cases.negative` (description, prompt), `demo_recording_url`, `commerce: false`.
- `publication`: release_notes, translations (pt-PT subtitle and description).

Portal steps:
1. Upload plugin (the ZIP).
2. MCPs tab: Connect, sign in with the test account, then Rescan. Fix every finding on the server and Rescan again; text changes put tools back in "needs further review", which is a manual review, not an error.
3. Domain verification: the token is served as plain text at `https://<host>/.well-known/openai-apps-challenge` (here read from `/var/lib/portal/openai-apps-challenge`, so it changes without a deploy).
4. Review details: "Username and password", Login URL, Username, Password, Sign-in steps.
5. Supporting content: an unlisted YouTube or Loom video showing the connection, 3 or 4 test cases, a confirmation in the account (here `/conta/alertas`) and one negative case.

Sign-in steps used:

> Connect the app, choose the "Palavra-passe" (password) tab on the sign-in page, enter the username and password above and click "Autorizar" (Authorize). No MFA, email codes or magic links. The account has sample data: one alert (Braga) with unseen updates, one favourite (PI12177) and admin access to a demonstration agency with 5 example listings. Search covers Portugal only.

Negative cases used: advertisers' contact details (never disclosed), a place outside Portugal (not guessed), bookings and payments (not available).

## 3. Claude: MCP connector

claude.ai/directory/manage, Submit new, "MCP connector" (10 steps):

1. **Connection**: `https://portalimobiliario.com.pt/mcp`. "Users connect to different URLs" unchecked.
2. **Tools**: read from the server.
3. **Listing**:
   - Name and slug (the slug is permanent).
   - One-liner: "Search homes for sale and rent in Portugal, compare prices per m² and get new-listing alerts."
   - Description: the same text as the OpenAI longDescription, shortened to 2000 characters.
   - Categories and author (Portal Imobiliário, https://portalimobiliario.com.pt).
   - Custom icon URL `https://portalimobiliario.com.pt/apple-icon.png`, because the SVG favicon or a missing `/favicon.ico` can fail.
4. **Links**:
   - Documentation: https://portalimobiliario.com.pt/profissionais/ia
   - Support: info@portalimobiliario.com.pt
   - Privacy: https://portalimobiliario.com.pt/privacidade
5. **Use cases**:
   - Search homes: "Find 3-bedroom apartments for sale in Braga under €300,000".
   - Prices per m²: "What is the price per m² for apartments in Cascais and how did it change in the last year?"
   - Alerts: "Alert me daily about houses with a pool for sale in Faro under €800,000".
   - Prerequisites: which account is needed and which tools each account type sees.
   - Capabilities: "Read and write".
6. **Company**.
7. **Authentication**: OAuth with DCR; client ID and secret left empty.
8. **Data handling**.
9. **Test & launch**: the server URL, how to sign in with the test account's password, the sample data and 5 or 6 prompts with the tool each should call. Check "Self-tested" only when every tool has been run through MCP Inspector or as a custom connector in Claude.
10. **Compliance**, then **Review and submit**.

## 4. Claude: plugin bundle

Submit new, "Plugin bundle" (5 steps: Source, Listing details, Data handling, Compliance, Review and submit).

- The repository must be public to be published (private repositories are only validated and reviewed). Check the whole history for credentials first.
- The Claude plugin lives in `claude/`, a folder with text files only. Set it under "Plugin in a subfolder or on another branch?". With the OpenAI package in the same folder the validator raises:
  - a policy hold: "Image or font file that the plugin's code could run";
  - false "download-and-run" warnings on the PNG screenshots.
- `claude/.claude-plugin/plugin.json`: name, displayName, version, description, author, homepage, repository, license, privacyPolicyUrl. The "Unrecognized field privacyPolicyUrl" warning is expected; keep the field, the directory reads it.
- `claude/.claude-plugin/icon.png`: a square PNG or JPEG of 512 to 2048 px, under 2 MB. It is read only the first time the plugin is saved or submitted, so commit it before.
- README of 40+ words and a LICENSE inside `claude/`. Validate locally with `claude plugin validate claude`.
- **Data handling**:
  - Personal data: "Reads and stores". The tools read enquiries and store contact details of listings, the agency page and agents.
  - Data sent to other services: "No".
  - Retention: "Longer". Alerts, favourites, listings and changes stay in the account.
  - Under 18: "No".
- After approval: GitHub Settings, Webhooks, the URL given by the directory, `application/json`, push events only. Every push to `main` updates the plugin.

## 5. Other directories

- MCP Registry: `server.json` at the root (`io.github.shopwhizzy/portalimobiliario-mcp`, remote streamable-http).
- Cursor Directory: repository with `plugin.json` and `mcp.json` at the root (Agent Plugins format).
