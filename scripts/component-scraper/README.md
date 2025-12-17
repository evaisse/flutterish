# Component Scraper

This tool scrapes component lists from MUI and Framework7 websites and creates GitHub issues for each component to be implemented in the Flutterish library.

## Features

- Scrapes components from:
  - Material UI (MUI): https://mui.com/components/
  - Framework7: https://framework7.io/kitchen-sink/core/?theme=md
- Generates structured JSON data with component information
- Creates GitHub issues automatically using GitHub CLI

## Prerequisites

- Node.js v18+ 
- npm or yarn
- GitHub CLI (`gh`) - [Installation guide](https://cli.github.com/)
- Authenticated GitHub CLI session (`gh auth login`)

## Installation

```bash
cd scripts/component-scraper
npm install
```

## Usage

### Step 1: Scrape Components

```bash
npm run scrape
```

This will:
1. Launch a headless browser
2. Navigate to MUI and Framework7 websites
3. Extract component information
4. Save results to `components.json`

### Step 2: Create GitHub Issues

**Dry run (preview without creating issues):**

```bash
DRY_RUN=true npm run create-issues
```

**Create issues:**

```bash
npm run create-issues
```

This will create one GitHub issue for each component found.

## Output Format

The `components.json` file contains:

```json
{
  "generatedAt": "2025-12-16T23:22:00.000Z",
  "totalComponents": 150,
  "sources": {
    "mui": 80,
    "framework7": 70
  },
  "components": [
    {
      "name": "Accordion",
      "slug": "accordion",
      "url": "https://mui.com/material-ui/react-accordion/",
      "category": "MUI Component",
      "source": "mui"
    }
  ]
}
```

## GitHub Issue Template

Each issue created will include:

- **Title**: "Implement [Component Name] component"
- **Labels**: `component`, `mui` or `framework7`
- **Body**: 
  - Component description
  - Source framework and reference URL
  - Implementation checklist (widget, tests, docs, etc.)
  - Notes and requirements

## GitHub Actions Integration

You can automate this process using GitHub Actions. See the workflow file:

`.github/workflows/create-component-issues.yml`

## Troubleshooting

### Scraping fails

- Check your internet connection
- Some websites may block automated scraping - you may need to adjust selectors
- Try updating Playwright: `npm install playwright@latest`

### Issue creation fails

- Ensure you're authenticated with GitHub CLI: `gh auth status`
- Check repository permissions
- Review rate limits if creating many issues

## Manual Components JSON

If scraping doesn't work, you can manually create `components.json`:

```json
{
  "generatedAt": "2025-12-16T23:22:00.000Z",
  "totalComponents": 2,
  "components": [
    {
      "name": "Button",
      "slug": "button",
      "url": "https://mui.com/material-ui/react-button/",
      "category": "MUI Component",
      "source": "mui"
    },
    {
      "name": "Card",
      "slug": "card", 
      "url": "https://framework7.io/docs/card.html",
      "category": "Framework7 Component",
      "source": "framework7"
    }
  ]
}
```

Then run `npm run create-issues` to create issues from this file.

## Development

The scraper uses:
- **Playwright**: For browser automation
- **Cheerio**: For HTML parsing (if needed)
- **GitHub CLI**: For issue creation

### Modifying Selectors

If the websites change their structure, update selectors in `scrape-components.js`:

```javascript
const SOURCES = {
  mui: {
    url: 'https://mui.com/components/',
    name: 'Material UI (MUI)',
    selector: 'nav a[href^="/material-ui/react-"]', // Update this
  },
  // ...
};
```

## License

This tool is part of the Flutterish project and follows the same license.
