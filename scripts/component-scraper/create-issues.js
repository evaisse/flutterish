#!/usr/bin/env node

/**
 * GitHub Issue Creator for Components
 * 
 * This script reads components.json and creates GitHub issues
 * for each component using the GitHub CLI (gh)
 */

import { readFileSync, existsSync } from 'fs';
import { execSync } from 'child_process';

const COMPONENTS_FILE = 'components.json';
const LABEL = 'component';
const DRY_RUN = process.env.DRY_RUN === 'true';

/**
 * Create a GitHub issue for a component
 */
function createIssue(component) {
  const { name, slug, url, source, category } = component;
  
  const title = `Implement ${name} component`;
  
  const body = `## Component: ${name}

### Source
- **Framework**: ${source === 'mui' ? 'Material UI (MUI)' : 'Framework7'}
- **Reference URL**: ${url}
- **Category**: ${category}

### Description
Implement the **${name}** component for the Flutterish library.

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
Please refer to the original documentation at: ${url}

### Notes
This component should be implemented following the patterns established in the existing Flutterish components (e.g., Stepper component).

---
*Auto-generated issue for component implementation*`;

  if (DRY_RUN) {
    console.log('\n' + '='.repeat(80));
    console.log(`DRY RUN - Would create issue:`);
    console.log(`Title: ${title}`);
    console.log(`Labels: ${LABEL}, ${source}`);
    console.log('Body:');
    console.log(body);
    console.log('='.repeat(80));
    return { success: true, dryRun: true };
  }

  try {
    // Create the issue using gh CLI
    const command = `gh issue create --title "${title.replace(/"/g, '\\"')}" --body "${body.replace(/"/g, '\\"')}" --label "${LABEL},${source}"`;
    
    const result = execSync(command, {
      encoding: 'utf8',
      stdio: 'pipe'
    });
    
    console.log(`✅ Created issue for: ${name}`);
    console.log(`   URL: ${result.trim()}`);
    
    return { success: true, url: result.trim() };
  } catch (error) {
    console.error(`❌ Failed to create issue for ${name}:`, error.message);
    return { success: false, error: error.message };
  }
}

/**
 * Main execution
 */
async function main() {
  console.log('GitHub Issue Creator\n');
  
  // Check if components file exists
  if (!existsSync(COMPONENTS_FILE)) {
    console.error(`Error: ${COMPONENTS_FILE} not found!`);
    console.error('Please run "npm run scrape" first to generate the components data.');
    process.exit(1);
  }
  
  // Load components
  const data = JSON.parse(readFileSync(COMPONENTS_FILE, 'utf8'));
  const components = data.components || [];
  
  console.log(`Found ${components.length} components to process\n`);
  
  if (DRY_RUN) {
    console.log('🔍 DRY RUN MODE - No issues will be created\n');
  }
  
  // Check if gh CLI is available
  if (!DRY_RUN) {
    try {
      execSync('gh --version', { stdio: 'pipe' });
    } catch (error) {
      console.error('Error: GitHub CLI (gh) is not installed or not available');
      console.error('Please install it from: https://cli.github.com/');
      process.exit(1);
    }
  }
  
  // Create issues
  const results = {
    success: 0,
    failed: 0,
    total: components.length
  };
  
  for (const component of components) {
    const result = createIssue(component);
    
    if (result.success) {
      results.success++;
    } else {
      results.failed++;
    }
    
    // Add a small delay to avoid rate limiting
    if (!DRY_RUN) {
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
  }
  
  // Summary
  console.log('\n' + '='.repeat(80));
  console.log('Summary:');
  console.log(`Total components: ${results.total}`);
  console.log(`Successfully created: ${results.success}`);
  console.log(`Failed: ${results.failed}`);
  console.log('='.repeat(80));
  
  if (results.failed > 0) {
    process.exit(1);
  }
}

main();
