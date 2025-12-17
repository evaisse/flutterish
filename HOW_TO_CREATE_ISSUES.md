# How to Create Component Issues - Step by Step

This guide will walk you through creating GitHub issues for all 60 UI components (30 from MUI, 30 from Framework7).

## 🎯 Goal

Create one GitHub issue for each component with:
- Component name and description
- Link to official documentation
- Implementation checklist
- Appropriate labels

## ⚡ Quick Start (Recommended)

### Using GitHub Actions - No Installation Required!

1. **Navigate to Actions**
   - Go to: https://github.com/evaisse/flutterish/actions
   - Or click the "Actions" tab in your repository

2. **Select the Workflow**
   - Find "Create Component Issues" in the left sidebar
   - Click on it

3. **Run the Workflow (Dry Run First)**
   - Click the "Run workflow" button (blue button on the right)
   - Configure options:
     - `dry_run`: **true** ← START WITH THIS
     - `sources`: **both** (or choose mui/framework7)
   - Click "Run workflow" (green button)

4. **Review the Dry Run Results**
   - Wait for workflow to complete (~2-3 minutes)
   - Click on the workflow run to see details
   - Check the Summary section
   - Review what components were found
   - Download the `components-data` artifact to see JSON

5. **Create Actual Issues**
   - Click "Run workflow" again
   - This time set `dry_run`: **false**
   - Click "Run workflow"
   - Wait for completion (~5-10 minutes for 60 issues)

6. **Verify Issues Created**
   - Go to: https://github.com/evaisse/flutterish/issues
   - You should see 60 new issues!
   - Each labeled with `component` and `mui` or `framework7`

## 📋 What You'll Get

After running the workflow, you'll have:

### 60 GitHub Issues Created

**30 MUI Components:**
- Accordion, Alert, Autocomplete, Avatar, Badge
- Button, Card, Checkbox, Chip, Dialog
- Drawer, Menu, Pagination, Progress, Radio
- Rating, Select, Skeleton, Slider, Snackbar
- Tabs, TextField, ToggleButton, Tooltip
- AppBar, BottomNavigation, Breadcrumbs, Link
- SpeedDial, Table

**30 Framework7 Components:**
- ActionSheet, Accordion, Badge, Button, Card
- Checkbox, Chip, Dialog, Fab, List
- Popup, Popover, SheetModal, Toast, Preloader
- ProgressBar, Swiper, PhotoBrowser, Notification
- Navbar, Toolbar, Searchbar, Messages, Messagebar
- Swipeout, DataTable, PullToRefresh, InfiniteScroll
- Stepper, RangeSlider

### Each Issue Contains:

```markdown
## Component: [Name]

### Source
- Framework: Material UI (MUI) or Framework7
- Reference URL: [Link to docs]
- Category: [Component Category]

### Description
Implement the [Name] component for the Flutterish library.

### Requirements
☐ Create Flutter widget implementation
☐ Follow Flutter best practices and conventions
☐ Ensure accessibility (Semantics widgets, ARIA labels)
☐ Add theme support (ThemeExtension)
☐ Write unit tests
☐ Write widget tests
☐ Add golden tests
☐ Update documentation
☐ Add example usage in example app

### Reference
Please refer to the original documentation at: [URL]
```

## 🔧 Alternative: Local Execution

If you prefer to run locally:

### Prerequisites

```bash
# Check Node.js (need v18+)
node --version

# Install GitHub CLI if needed
brew install gh  # macOS
# OR see: https://cli.github.com/

# Authenticate
gh auth login
```

### Steps

```bash
# 1. Navigate to the tool
cd scripts/component-scraper

# 2. Install dependencies (first time only)
npm install

# 3. Copy example data (skip scraping for now)
cp components.example.json components.json

# 4. Preview what will be created (DRY RUN)
DRY_RUN=true npm run create-issues

# 5. Create actual issues
npm run create-issues
```

## 📊 Expected Timeline

- **Dry Run**: ~1 minute
- **Creating 60 Issues**: ~5-10 minutes (with rate limiting)
- **Total**: ~10-15 minutes from start to finish

## ✅ Success Indicators

You'll know it worked when:

1. ✓ Workflow shows green checkmark
2. ✓ Summary shows "60 components found"
3. ✓ Issues tab shows 60 new issues
4. ✓ Issues are labeled correctly
5. ✓ Each issue has proper formatting

## 🎯 Next Steps After Creating Issues

1. **Review the Issues**
   - Browse through a few to ensure quality
   - Check that links work
   - Verify formatting is correct

2. **Organize Issues**
   - Add milestones for phased implementation
   - Prioritize which components to build first
   - Assign to team members

3. **Start Implementing**
   - Pick an issue to start with
   - Follow the checklist in the issue
   - Reference existing Stepper component for patterns
   - Close issue when complete

## 🐛 Troubleshooting

### Workflow Fails

**Error**: "Playwright not installed"
- Solution: The workflow should auto-install. Try re-running.

**Error**: "Permission denied"
- Solution: Check workflow has `issues: write` permission in settings

### No Issues Created in Dry Run

**Problem**: Workflow completes but no issues appear
- Check: Are you running with `dry_run: false`?
- Solution: Run again without dry run

### Duplicate Issues

**Problem**: Issues already exist
- Solution: Close or delete old issues first
- Or: Filter in `create-issues.js` to skip existing

### Rate Limiting

**Problem**: "API rate limit exceeded"
- Solution: Wait a few minutes and try again
- Or: Run in smaller batches

## 📚 More Information

- **Full Documentation**: See [COMPONENT_ISSUES.md](COMPONENT_ISSUES.md)
- **Quick Reference**: See [scripts/component-scraper/QUICKSTART.md](scripts/component-scraper/QUICKSTART.md)
- **Technical Details**: See [scripts/component-scraper/README.md](scripts/component-scraper/README.md)

## 💡 Pro Tips

1. **Always run dry run first** - Preview before creating
2. **Start with one source** - Try `mui` only first if nervous
3. **Test with small batch** - Edit example JSON to have 5 components
4. **Keep artifact** - Download components.json from workflow for reference
5. **Monitor progress** - Watch the workflow logs in real-time

## 🎉 You're Ready!

Go ahead and run the workflow. In about 10 minutes, you'll have 60 component issues ready for implementation!

**Quick Link**: https://github.com/evaisse/flutterish/actions/workflows/create-component-issues.yml

---

**Questions?** Check the documentation or create an issue for help.
