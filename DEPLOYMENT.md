# Deployment Guide

This document describes the deployment process for the Flutterish demo application.

## Overview

The Flutterish demo app is automatically deployed using GitHub Actions to PocketHost.io:

- **Production**: `flutterish.pockethost.io` (from `main`/`master` branch)
- **Staging**: `flutterish-staging.pockethost.io` (from `staging` branch)

## GitHub Actions Workflows

### 1. Build and Test (`build-test.yml`)
- Runs on every push and pull request
- Tests both main package and example app
- Verifies WASM build compatibility
- Runs Flutter analysis and tests

### 2. Deploy Production (`deploy-production.yml`)
- Triggers on push to `main` or `master` branch
- Builds Flutter web app with WASM support
- Deploys to production PocketHost.io instance
- Base href: `/flutterish/`

### 3. Deploy Staging (`deploy-staging.yml`)
- Triggers on push to `staging` branch
- Builds Flutter web app with WASM support
- Deploys to staging PocketHost.io instance
- Base href: `/flutterish-staging/`
- Includes staging environment indicators

## Required Secrets

Configure these secrets in GitHub repository settings:

### Production
- `POCKETHOST_PRODUCTION_URL`: PocketHost.io production deployment URL
- `POCKETHOST_PRODUCTION_TOKEN`: Authentication token for production

### Staging  
- `POCKETHOST_STAGING_URL`: PocketHost.io staging deployment URL
- `POCKETHOST_STAGING_TOKEN`: Authentication token for staging

## Manual Deployment

You can trigger deployments manually using the "workflow_dispatch" trigger in GitHub Actions.

## PocketHost.io Setup

1. Create accounts for both production and staging environments
2. Configure the domains:
   - `flutterish.pockethost.io`
   - `flutterish-staging.pockethost.io`
3. Generate deployment tokens/credentials
4. Add the credentials as GitHub secrets

## Build Configuration

The Flutter web build uses the following configuration:
- WASM enabled for better performance
- Release mode for production builds
- Custom base href for proper routing
- Web renderer: auto (defaults to CanvasKit when WASM is available)

## File Structure

```
example/
├── build/web/          # Built Flutter web app
├── web/               # Web-specific files
├── lib/main.dart      # Main Flutter app
└── pubspec.yaml       # Dependencies
```

## Troubleshooting

### Build Issues
- Ensure Flutter version 3.24.0+ for WASM support
- Check `flutter doctor` output for missing dependencies
- Verify web support is enabled: `flutter config --enable-web`

### Deployment Issues  
- Check GitHub Actions logs for detailed error messages
- Verify secrets are properly configured
- Ensure PocketHost.io endpoints are accessible

### WASM Issues
- WASM requires HTTPS in production
- Some browsers may need additional configuration
- Falls back to JavaScript if WASM is not supported

## Branch Strategy

- `main`/`master`: Production-ready code, auto-deploys to production
- `staging`: Testing branch, auto-deploys to staging environment
- Feature branches: Create from `main`, merge via PR after testing

## Testing Deployments

After deployment, verify:
1. App loads correctly at the target URL
2. WASM features work as expected
3. No console errors
4. Mobile compatibility
5. Performance meets expectations