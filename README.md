# Portal Imobiliário for Claude and ChatGPT

Connect [Portal Imobiliário](https://portalimobiliario.com.pt), the free real estate portal for Portugal, to Claude, ChatGPT or any MCP client.

- **MCP server:** `https://portalimobiliario.com.pt/mcp` (Streamable HTTP)
- **Sign-in:** OAuth 2.1 with PKCE, dynamic client registration and client ID metadata documents. Discovery at `/.well-known/oauth-protected-resource` and `/.well-known/oauth-authorization-server`.
- **Account:** created on the first sign-in (email link, password or Google).

## What it does

One connector; the tools shown depend on the account.

**Everyone (people looking for a home)**

| Tool | What it does |
|---|---|
| `search_properties` | Search listings for sale or rent: place, type, price, area, bedrooms, features, condition, new builds, price against market value |
| `get_listing` | One listing: price, €/m², market comparison, areas, features, description, photos, advertiser |
| `area_prices` | Price per m² of a district, municipality or parish: INE sales and rents, yearly change, bank valuation, portal asking prices |
| `list_favorites`, `add_favorite`, `remove_favorite` | Favourites (the same as on the site) |
| `create_alert`, `list_alerts`, `update_alert`, `delete_alert` | Saved searches with alerts for new listings and price drops (email, account notice and in the assistant) |
| `alert_updates` | What the alerts found and was not seen yet |
| `search`, `fetch` | Free-text search and full listing text (ChatGPT connectors and deep research) |
| `simulate_imt`, `simulate_mortgage`, `simulate_capital_gains`, `estimate_value`, `official_prices`, `market_stats`, `find_location`, `whoami` | Calculators and official data |

**Agencies and owners** also get listing tools, one per operation: listings (`create_property`, `update_property`, `import_properties`, `import_csv`, `set_status`, `delete_property`), photos (`add_photos`, `list_photos`, `delete_photos`, `reorder_photos`, `set_cover_photo`), CRM feeds (`list_feeds`, `test_feed`, `add_feed`, `run_feed`, `toggle_feed`, `delete_feed`), enquiries (`list_leads`, `mark_leads_read`, `archive_leads`), the agency page (`get_agency`, `update_agency`, `list_agents`, `add_agent`, `list_agency_reviews`, `reply_to_review`), new developments (`list_developments`, `get_development`, `create_development`, `update_development`, `link_development_units`, `unlink_development_units`, `delete_development`), reports and exports. See [docs/TOOLS.md](docs/TOOLS.md).

## Privacy

- Searches made through the assistant are **not linked to the account**: the portal keeps only aggregated daily counts per tool, business type, property type and area.
- Alerts and favourites created through the assistant live in the account, like those created on the site.
- Advertisers' contact details are never returned. Contact goes through the form on the listing page.
- Actions on listings are kept in the account's activity log without personal data.
- Full policy: https://portalimobiliario.com.pt/privacidade

## Package

This repository is the plugin package for the OpenAI plugin directory (Agent Plugins format) and a Claude Code plugin:

```
plugin.json                        OpenAI (Agent Plugins) manifest + extensions.com.openai (listing, review cases, publication)
mcp.json                           remote MCP server for Agent Plugins (OAuth, CIMD with DCR fallback)
assets/                            logo, dark logo, screenshots (OpenAI listing)
claude/                            the Claude plugin: .claude-plugin/plugin.json, .mcp.json, skills/, README, LICENSE
server.json                        MCP Registry entry
```

The skills live in `claude/skills/` and are copied into the OpenAI ZIP by `scripts/package.sh`.

Build the ZIP with `./scripts/package.sh`: one `portal-imobiliario/` folder with the plugin files, no `.git`.

## Support

https://portalimobiliario.com.pt/contactos · info@portalimobiliario.com.pt
