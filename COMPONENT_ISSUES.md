# Component Issues Generation Guide

This document explains how to generate GitHub issues for UI components from MUI and Framework7 libraries.

## Overview

The component scraper tool automates the process of:

1. **Scraping** component lists from MUI and Framework7 documentation
2. **Generating** structured JSON data with component information
3. **Creating** GitHub issues for each component with implementation checklists

## Quick Start

### Option 1: GitHub Actions (Recommended) ⭐

The easiest way to generate issues without installing anything locally.

**Steps:**

1. Navigate to your repository on GitHub
2. Go to **Actions** → **Create Component Issues**
3. Click **Run workflow**
4. Select options:
   - `dry_run: true` (recommended first time)
   - `sources: both` (or choose specific source)
5. Click **Run workflow**
6. Review the workflow summary
7. If satisfied, run again with `dry_run: false`

**Benefits:**
- No local setup required
- Runs in GitHub's infrastructure
- No rate limiting issues
- Automated and repeatable

### Option 2: Local Execution

For developers who want more control or need to customize the process.

**Prerequisites:**
```bash
# Node.js 18+ and npm
node --version  # Should be v18+

# GitHub CLI (for creating issues)
gh --version
gh auth login   # Authenticate with GitHub
```

**Steps:**
```bash
# 1. Navigate to scraper directory
cd scripts/component-scraper

# 2. Install dependencies
npm install
npx playwright install chromium

# 3. Scrape component data
npm run scrape

# 4. Preview issues (dry run)
DRY_RUN=true npm run create-issues

# 5. Create actual issues
npm run create-issues
```

### Option 3: Use Example Data

Test the issue creation without scraping:

```bash
cd scripts/component-scraper
cp components.example.json components.json
DRY_RUN=true npm run create-issues  # Preview
npm run create-issues                 # Create issues
```

The example data includes 60 pre-defined components (30 from MUI, 30 from Framework7).

## What Gets Created

For each component, a GitHub issue is created with:

### Issue Title
```
Implement [Component Name] component
```

### Labels
- `component` - Identifies it as a component implementation task
- `mui` or `framework7` - Source framework

### Issue Body

```markdown
## Component: [Name]

### Source
- **Framework**: Material UI (MUI) or Framework7
- **Reference URL**: [Link to official documentation]
- **Category**: [Component Category]

### Description
Implement the **[Name]** component for the Flutterish library.

### Requirements
- [ ] Create Flutter widget implementation
- [ ] Follow Flutter best practices and conventions
- [ ] Ensure accessibility (Semantics widgets, ARIA labels)
- [ ] Add theme support (ThemeExtension)
- [ ] Write unit tests
- [ ] Write widget tests
- [ ] Add golden tests
- [ ] Update documentation
- [ ] Add example usage in example app

### Reference
Please refer to the original documentation at: [URL]

### Notes
This component should be implemented following the patterns 
established in the existing Flutterish components (e.g., Stepper component).
```

## Component Sources

### Material UI (MUI)
- **Website**: https://mui.com/components/
- **Components**: 30+ UI components
- **Categories**: Inputs, Data Display, Feedback, Surfaces, Navigation, Layout, Utils

**Example Components:**
- Accordion, Alert, Autocomplete, Avatar, Badge
- Button, Card, Checkbox, Chip, Dialog
- Drawer, Menu, Pagination, Progress, Radio
- Rating, Select, Skeleton, Slider, Snackbar
- Tabs, TextField, ToggleButton, Tooltip
- AppBar, BottomNavigation, Breadcrumbs, Link
- SpeedDial, Table, and more...

### Framework7
- **Website**: https://framework7.io/kitchen-sink/core/?theme=md
- **Components**: 30+ mobile-focused UI components
- **Categories**: Layout, Modals, Navigation, Forms, Data, Media

**Example Components:**
- ActionSheet, Accordion, Badge, Button, Card
- Checkbox, Chip, Dialog, Fab, List
- Popup, Popover, SheetModal, Toast, Preloader
- ProgressBar, Swiper, PhotoBrowser, Notification
- Navbar, Toolbar, Searchbar, Messages, Messagebar
- Swipeout, DataTable, PullToRefresh, InfiniteScroll
- Stepper, RangeSlider, and more...

## Customization

### Filtering Components

Edit `create-issues.js` to filter components before creating issues:

```javascript
// Only MUI components
const components = data.components.filter(c => c.source === 'mui');

// Only Framework7 components
const components = data.components.filter(c => c.source === 'framework7');

// Components starting with specific letter
const components = data.components.filter(c => c.name.startsWith('B'));

// First 10 components only
const components = data.components.slice(0, 10);
```

### Modifying Issue Template

Edit the `createIssue()` function in `create-issues.js` to customize:

- Issue title format
- Issue body content
- Labels
- Additional metadata

### Adding Custom Components

Add to `components.json` or create your own data file:

```json
{
  "generatedAt": "2025-12-16T23:22:00.000Z",
  "totalComponents": 1,
  "components": [
    {
      "name": "My Custom Component",
      "slug": "my-custom-component",
      "url": "https://example.com/docs/my-component",
      "category": "Custom Category",
      "source": "custom"
    }
  ]
}
```

## Workflow Details

### The Scraping Process

The scraper:

1. Launches a headless Chromium browser
2. Navigates to MUI components page
3. Extracts component links from sidebar navigation
4. Navigates to Framework7 kitchen sink
5. Extracts component links from component list
6. Combines and deduplicates results
7. Saves to `components.json`

### The Issue Creation Process

The script:

1. Reads `components.json`
2. For each component:
   - Generates issue title and body
   - Adds appropriate labels
   - Creates issue via GitHub CLI
   - Waits 1 second (rate limiting)
3. Reports summary

## Troubleshooting

### Scraping Issues

**Problem**: Scraping fails or returns no components

**Solutions:**
- Check internet connectivity
- Verify website URLs are accessible
- Websites may have changed structure - update selectors in `scrape-components.js`
- Use example data as fallback

**Problem**: Some components are missing

**Solutions:**
- Website navigation may have changed
- Update CSS selectors in `scrape-components.js`
- Manually add missing components to `components.json`

### Issue Creation Issues

**Problem**: `gh: command not found`

**Solution:**
```bash
# macOS
brew install gh

# Linux
# See: https://github.com/cli/cli/blob/trunk/docs/install_linux.md

# Windows
# See: https://github.com/cli/cli#windows
```

**Problem**: Not authenticated

**Solution:**
```bash
gh auth login
# Follow the prompts
```

**Problem**: Rate limiting

**Solution:**
- Script includes 1-second delays
- If still hitting limits, run in batches
- Use GitHub Actions (higher limits)

**Problem**: Duplicate issues

**Solution:**
- Check existing issues before running
- Use dry run first: `DRY_RUN=true npm run create-issues`
- Filter components in `create-issues.js`

## Best Practices

1. **Always run dry run first** to preview what will be created
2. **Review example data** before scraping to understand the format
3. **Check existing issues** to avoid duplicates
4. **Start small** - test with a few components first
5. **Document changes** if you modify the scripts
6. **Keep backups** of `components.json` after successful scraping

## File Structure

```
scripts/component-scraper/
├── README.md                    # Detailed documentation
├── QUICKSTART.md               # Quick start guide
├── package.json                # Node.js dependencies
├── scrape-components.js        # Web scraper
├── create-issues.js            # Issue creator
├── components.example.json     # Example data (60 components)
└── components.json             # Generated data (gitignored)
```

## GitHub Actions Workflow

Located at: `.github/workflows/create-component-issues.yml`

**Features:**
- Manual trigger with options
- Installs dependencies automatically
- Runs scraper
- Creates issues (with dry run option)
- Uploads components.json as artifact
- Generates workflow summary

**Usage:**
```yaml
on:
  workflow_dispatch:
    inputs:
      dry_run: true/false
      sources: both/mui/framework7
```

## Next Steps After Creating Issues

1. **Review Issues**: Check the created issues in your repository
2. **Prioritize**: Label or milestone components by priority
3. **Assign**: Assign issues to team members
4. **Track**: Use project boards to track progress
5. **Implement**: Follow the checklist in each issue
6. **Close**: Close issues as components are completed

## Support

For issues or questions:

1. Check existing documentation
2. Review script comments
3. Run with dry run to debug
4. Create a GitHub issue in the repository

## Contributing

Improvements welcome:

- Better selectors for scraping
- Support for additional component libraries
- Enhanced issue templates
- Additional metadata in components.json

## License

This tool is part of the Flutterish project and follows the same license.

---

**Happy component building!** 🚀
