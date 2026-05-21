# Fern-to-Docusaurus Migration Agent Prompt

## Objective

Migrate SignalWire's documentation from the Fern platform back into a Docusaurus site. The Fern version reorganized content, added new docs, and uses Fern-specific components. We need to replicate all of Fern's content and URL structure in Docusaurus.

## Directory Layout

- **Fern source content:** `temp/signalwire-fern-config/fern/` — contains all Fern products, navigation YAML, snippets, assets, and OpenAPI/TypeSpec specs
- **Original Docusaurus site (reference only):** `website/` — the old working Docusaurus site, useful for understanding existing components, config patterns, and styling
- **New Docusaurus site (target):** `website-v2/` — copied from `website/`, this is where all migration work happens

## What Fern Has

The Fern docs site is defined in `temp/signalwire-fern-config/fern/docs.yml`. It contains:

### Products (each becomes a section in the secondary navbar)
1. **Home** — landing/getting started pages
2. **Platform** — has 5 tabs: Platform, Calling, AI, Messaging, Tools
3. **SWML** — has 2 tabs: Reference, Guides
4. **Call Flow Builder** — single section
5. **Agents SDK** — has 2 tabs: Guides, Reference
6. **Server SDK** (realtime SDK) — versioned (v4/current, v3, v2), each version has tabs
7. **Browser SDK** — versioned (v3/current, v2), each version has tabs
8. **APIs** — REST API overview pages + auto-generated endpoint docs from OpenAPI specs
9. **Compatibility API** — has 3 tabs: cXML, SDKs, REST API

### Fern-Specific Components Used in Content
These don't exist in Docusaurus and need wrapper/adapter components:
- `<ParamField>` (2,639 usages) — API parameter documentation fields
- `<CodeBlocks>` / `<CodeBlock>` (372/329) — tabbed code examples
- `<Indent>` (256) — indented content blocks
- `<Frame>` (163) — image/content frames with captions
- `<Accordion>` / `<AccordionGroup>` (143/16) — collapsible sections
- `<CardGroup>` / `<Card>` (90/37) — grid card layouts
- `<Markdown src="/snippets/...">` (39) — snippet inclusion (convert to MDX imports)
- `<Steps>` / `<Step>` (26/19) — numbered step sequences
- `<EndpointRequestSnippet>`, `<EndpointResponseSnippet>`, `<EndpointSchemaSnippet>`, `<SchemaSnippet>`, `<WebhookPayloadSnippet>` (133 total) — inline API schema references
- `<Files>`, `<Folder>`, `<File>` — file tree visualization
- `<Tooltip>` (4) — hover tooltips
- Callout components: `<Warning>`, `<Info>`, `<Tip>`, `<Note>`, `<Success>`, `<Error>` (~300)

### Fern Frontmatter Differences
Fern MDX uses different frontmatter keys than Docusaurus:
- `subtitle:` → use as `description:`
- `sidebar-title:` → `sidebar_label:`
- `hide-toc: true` → `hide_table_of_contents: true`
- `position: N` → `sidebar_position: N`
- `slug:` → keep, but prefix with the product slug to get the full Fern URL
- `id: <UUID>` → remove

### Fern Content Syntax Differences
- `[#anchor]` heading syntax → `{#anchor}`
- `class=` in JSX → `className=`
- Image paths use `/assets/images/` (served from `static/assets/images/`)

## URL Structure Must Match Fern

Every page slug in Docusaurus must match the Fern URL. Fern builds URLs as: `/<product-slug>/<tab-slug>/<page-slug>`.

Key URL mappings:
- APIs product: `/apis/...` (overview pages at `/apis/overview`, `/apis/base-url`, etc.)
- API endpoints: `/apis/<api-name>/<endpoint>` (e.g., `/apis/calling/calling-api`)
- Compatibility API REST: `/compatibility-api/rest/<endpoint>`
- Platform: `/platform/...`, `/calling/...`, `/ai/...`, `/messaging/...`, `/tools/...`
- SWML: `/swml/...`, `/swml/guides/...`
- Server SDK: `/server-sdk/node/...` (current), `/server-sdk/v3/node/...`, `/server-sdk/v2/...`
- Browser SDK: `/browser-sdk/js/...` (current), `/browser-sdk/v2/js/...`
- Agents SDK: `/agents-sdk/python/...`

Check `docs.yml` and each product's YAML for the exact slug configuration. Every page's `slug` frontmatter in the migrated content must produce the same URL as Fern.

## File Placement

| Fern Source | Docusaurus Target |
|---|---|
| `fern/products/<product>/pages/` | `website-v2/docs/main/<product>/` (for main docs plugin) |
| `fern/products/agents-sdk/pages/` | `website-v2/docs/agents-sdk/` (separate docs plugin) |
| `fern/products/realtime-sdk/pages/latest/` | `website-v2/docs/realtime-sdk/` (current version) |
| `fern/products/realtime-sdk/pages/v3/` | `website-v2/realtime-sdk_versioned_docs/version-v3/` |
| `fern/products/realtime-sdk/pages/v2/` | `website-v2/realtime-sdk_versioned_docs/version-v2/` |
| `fern/products/browser-sdk/pages/latest/` | `website-v2/docs/browser-sdk/` (current version) |
| `fern/products/browser-sdk/pages/v2/` | `website-v2/browser-sdk_versioned_docs/version-v2/` |
| `fern/snippets/` | `website-v2/docs/_partials/` (prefixed with `_`) |
| `fern/assets/images/` | `website-v2/static/assets/images/` |

## OpenAPI / REST API Docs

- TypeSpec sources live in `website-v2/typespec/` and compile to OpenAPI YAML in `website-v2/specs/`
- The `docusaurus-plugin-openapi-docs` plugin reads from `specs/` and generates MDX in `docs/main/apis/<api-name>/` and `docs/main/compatibility-api/rest/`
- Config is in `website-v2/config/pluginsConfig/docusaurus-plugin-openapi-docs.ts`
- **Known issue:** The calling and fabric specs embed the full SWML schema tree which causes a JSON stringify overflow in the plugin. Use the simpler pre-Fern specs for these two.

## Sidebar Configuration

Sidebars are generated from Fern's navigation YAML files. Each product's YAML defines the sidebar structure with sections, pages, and links. The Docusaurus sidebar configs go in `website-v2/config/sidebarsConfig/`.

The secondary navbar (`website-v2/secondaryNavbar.ts`) defines the product switcher and tab navigation. It already supports the needed patterns (links arrays, versions, dropdowns).

## Key Config Files

- `website-v2/docusaurus.config.ts` — main Docusaurus config
- `website-v2/secondaryNavbar.ts` — product navigation structure
- `website-v2/config/sidebarsConfig/` — all sidebar definitions
- `website-v2/config/pluginsConfig/` — plugin configurations
- `website-v2/config/presets.ts` — Docusaurus preset config
- `website-v2/src/theme/MDXComponents/index.js` — global MDX component registration
- `website-v2/src/components/` — all custom components

## Guiding Principles

1. **Match Fern URLs exactly** — every slug must produce the same URL as the Fern site
2. **Every page should have a slug** in frontmatter matching its Fern URL
3. **Don't over-engineer components** — thin wrappers that make Fern MDX render correctly are fine
4. **Register all components globally** in `MDXComponents` so content files don't need imports
5. **Preserve existing Docusaurus infrastructure** — theme, plugins, build tooling all stay; we're replacing content and adding compatibility components
6. **Test with `yarn start`** — the dev server should load without errors after migration
