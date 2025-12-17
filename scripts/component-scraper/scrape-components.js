#!/usr/bin/env node

/**
 * Component Scraper for MUI and Framework7
 * 
 * This script scrapes component lists from:
 * - MUI: https://mui.com/components/
 * - Framework7: https://framework7.io/kitchen-sink/core/?theme=md
 * 
 * Output: components.json with structured data for each component
 */

import { chromium } from 'playwright';
import { writeFileSync } from 'fs';

const SOURCES = {
  mui: {
    url: 'https://mui.com/components/',
    name: 'Material UI (MUI)',
    selector: 'nav a[href^="/material-ui/react-"]',
  },
  framework7: {
    url: 'https://framework7.io/kitchen-sink/core/?theme=md',
    name: 'Framework7',
    selector: '.list-group a',
  }
};

/**
 * Scrape components from MUI website
 */
async function scrapeMUIComponents(page) {
  console.log('Scraping MUI components...');
  
  try {
    await page.goto(SOURCES.mui.url, { waitUntil: 'networkidle' });
    
    // Wait for navigation to be visible
    await page.waitForSelector('nav', { timeout: 10000 });
    
    // Extract component links from the sidebar navigation
    const components = await page.evaluate(() => {
      const links = [];
      const componentLinks = document.querySelectorAll('nav a[href*="/material-ui/react-"]');
      
      componentLinks.forEach(link => {
        const href = link.getAttribute('href');
        const text = link.textContent.trim();
        
        if (href && text && !href.includes('#')) {
          // Extract component name from URL
          const match = href.match(/\/material-ui\/react-(.+?)\/?$/);
          if (match) {
            const componentName = match[1];
            links.push({
              name: text,
              slug: componentName,
              url: `https://mui.com${href}`,
              category: 'MUI Component'
            });
          }
        }
      });
      
      return links;
    });
    
    console.log(`Found ${components.length} MUI components`);
    return components;
  } catch (error) {
    console.error('Error scraping MUI:', error.message);
    return [];
  }
}

/**
 * Scrape components from Framework7 website
 */
async function scrapeFramework7Components(page) {
  console.log('Scraping Framework7 components...');
  
  try {
    await page.goto(SOURCES.framework7.url, { waitUntil: 'networkidle' });
    
    // Wait for the component list to be visible
    await page.waitForSelector('.page-content', { timeout: 10000 });
    
    // Extract component links
    const components = await page.evaluate(() => {
      const links = [];
      const listItems = document.querySelectorAll('.list-group .item-link, .list li a');
      
      listItems.forEach(link => {
        const href = link.getAttribute('href');
        const text = link.textContent.trim();
        
        if (href && text && href.startsWith('/') && !href.includes('#')) {
          links.push({
            name: text,
            slug: href.split('/').filter(Boolean).pop() || text.toLowerCase().replace(/\s+/g, '-'),
            url: `https://framework7.io${href}`,
            category: 'Framework7 Component'
          });
        }
      });
      
      return links;
    });
    
    console.log(`Found ${components.length} Framework7 components`);
    return components;
  } catch (error) {
    console.error('Error scraping Framework7:', error.message);
    return [];
  }
}

/**
 * Main execution
 */
async function main() {
  console.log('Starting component scraping...\n');
  
  const browser = await chromium.launch({
    headless: true
  });
  
  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
  });
  
  const page = await context.newPage();
  
  try {
    // Scrape from both sources
    const muiComponents = await scrapeMUIComponents(page);
    const framework7Components = await scrapeFramework7Components(page);
    
    // Combine and deduplicate
    const allComponents = [
      ...muiComponents.map(c => ({ ...c, source: 'mui' })),
      ...framework7Components.map(c => ({ ...c, source: 'framework7' }))
    ];
    
    // Remove duplicates based on name
    const uniqueComponents = allComponents.reduce((acc, component) => {
      const key = `${component.source}-${component.slug}`;
      if (!acc.has(key)) {
        acc.set(key, component);
      }
      return acc;
    }, new Map());
    
    const components = Array.from(uniqueComponents.values());
    
    // Save to file
    const output = {
      generatedAt: new Date().toISOString(),
      totalComponents: components.length,
      sources: {
        mui: muiComponents.length,
        framework7: framework7Components.length
      },
      components: components
    };
    
    writeFileSync('components.json', JSON.stringify(output, null, 2));
    
    console.log('\n✅ Scraping complete!');
    console.log(`Total components found: ${components.length}`);
    console.log(`- MUI: ${muiComponents.length}`);
    console.log(`- Framework7: ${framework7Components.length}`);
    console.log('\nOutput saved to: components.json');
    
  } catch (error) {
    console.error('Fatal error:', error);
    process.exit(1);
  } finally {
    await browser.close();
  }
}

main();
