# Quick Start Guide

This guide will help you create GitHub issues for UI components from MUI and Framework7.

## Option 1: Use GitHub Actions (Recommended)

This is the easiest way if you want to scrape fresh component data and create issues automatically.

### Steps:

1. Go to your repository on GitHub
2. Click on **Actions** tab
3. Select **Create Component Issues** workflow
4. Click **Run workflow** button
5. Choose options:
   - **Dry run**: `true` (recommended first time to preview)
   - **Sources**: `both` (or choose `mui` or `framework7`)
6. Click **Run workflow**
7. Wait for the workflow to complete
8. Check the workflow summary to see what components were found
9. If satisfied with the dry run, run again with **Dry run** = `false` to create actual issues

### What happens:

- The workflow will scrape the latest component lists from MUI and Framework7 websites
- Generate a `components.json` file with all found components
- Create one GitHub issue for each component (unless dry run mode)
- Each issue includes:
  - Component name and description
  - Link to original documentation
  - Implementation checklist
  - Appropriate labels (`component`, `mui` or `framework7`)

## Option 2: Manual Local Execution

If you want to run the scripts locally:

### Prerequisites:

```bash
# Install Node.js 18+ and npm
# Install GitHub CLI
brew install gh  # macOS
# or visit: https://cli.github.com/

# Authenticate with GitHub
gh auth login
```

### Steps:

```bash
# Navigate to the scraper directory
cd scripts/component-scraper

# Install dependencies
npm install

# Install Playwright browsers
npx playwright install chromium

# Scrape components (requires internet access to mui.com and framework7.io)
npm run scrape

# Preview issues that would be created (dry run)
DRY_RUN=true npm run create-issues

# Create actual issues
npm run create-issues
```

## Option 3: Use Example Data

If you just want to test with pre-defined components without scraping:

```bash
cd scripts/component-scraper

# Copy example data
cp components.example.json components.json

# Preview what issues would be created
DRY_RUN=true npm run create-issues

# Create actual issues from example data
npm run create-issues
```

The example data includes 20 sample components (10 from MUI, 10 from Framework7).

## Expected Results

After running the issue creation, you should see:

- One GitHub issue per component
- Issues labeled with `component` and source (`mui` or `framework7`)
- Each issue contains:
  - Component name
  - Source framework and documentation link
  - Implementation requirements checklist
  - Notes about following Flutterish patterns

## Troubleshooting

### "gh: command not found"

Install GitHub CLI: https://cli.github.com/

### "Not authenticated with GitHub"

Run: `gh auth login`

### Scraping fails

- Check internet connection
- Websites may have changed structure - update selectors in `scrape-components.js`
- Use example data as fallback: `cp components.example.json components.json`

### Rate limiting

If you're creating many issues at once, you may hit GitHub API rate limits. The script includes a 1-second delay between issues, but you can:

- Run in batches
- Wait between runs
- Use the GitHub Actions workflow which has higher rate limits

## Next Steps

After issues are created:

1. Review the issues in your GitHub repository
2. Start implementing components by picking an issue
3. Follow the checklist in each issue
4. Close issues as components are completed

## Customization

### Modify Issue Template

Edit `create-issues.js` to change the issue title, body, or labels.

### Add More Components

Edit `components.json` or `components.example.json` to add custom components:

```json
{
  "name": "My Component",
  "slug": "my-component",
  "url": "https://example.com/docs/my-component",
  "category": "Custom Component",
  "source": "custom"
}
```

### Filter Components

Modify `create-issues.js` to filter components before creating issues:

```javascript
// Only create issues for MUI components
const components = data.components.filter(c => c.source === 'mui');

// Only components starting with 'A'
const components = data.components.filter(c => c.name.startsWith('A'));
```
