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
| `favorites` | List, add or remove favourites (the same as on the site) |
| `create_alert`, `list_alerts`, `update_alert`, `delete_alert` | Saved searches with alerts for new listings and price drops (email, account notice and in the assistant) |
| `alert_updates` | What the alerts found and was not seen yet |
| `search`, `fetch` | Free-text search and full listing text (ChatGPT connectors and deep research) |
| `simulate_imt`, `simulate_mortgage`, `simulate_capital_gains`, `estimate_value`, `official_prices`, `market_stats`, `find_location`, `whoami` | Calculators and official data |

**Agencies and owners** also get listing tools: `create_property`, `update_property`, `import_properties`, `import_csv`, `manage_feeds`, `manage_photos`, `audit_listings`, `manage_leads`, `manage_agency`, `manage_agents`, `agency_reviews`, `manage_developments`, reports and exports. See [docs/TOOLS.md](docs/TOOLS.md).

## Privacy

- Searches made through the assistant are **not linked to the account**: the portal keeps only aggregated daily counts per tool, business type, property type and area.
- Alerts and favourites created through the assistant live in the account, like those created on the site.
- Advertisers' contact details are never returned. Contact goes through the form on the listing page.
- Actions on listings are kept in the account's activity log without personal data.
- Full policy: https://portalimobiliario.com.pt/privacidade

## Package

This repository is the plugin package for the OpenAI plugin directory (Agent Plugins format) and a Claude Code plugin:

```
plugin.json                 portable manifest + extensions.com.openai (listing, review cases, publication)
mcp.json                    remote MCP server for Agent Plugins (OAuth, CIMD with DCR fallback)
.claude-plugin/plugin.json  Claude Code plugin manifest
.mcp.json                   Claude Code MCP server
skills/                     get-started (onboarding) and find-a-home
assets/                     logo, dark logo, screenshots
server.json                 MCP Registry entry
```

Build the ZIP with `./scripts/package.sh`: one `portal-imobiliario/` folder with the plugin files, no `.git`.

## Support

https://portalimobiliario.com.pt/contactos · info@portalimobiliario.com.pt
