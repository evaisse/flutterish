#!/bin/bash

# Flutterish Demo Deployment Script
# Usage: ./scripts/deploy.sh [staging|production] [--local-build-only]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
EXAMPLE_DIR="$PROJECT_ROOT/example"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Check if environment is provided
ENVIRONMENT="${1:-staging}"
LOCAL_BUILD_ONLY="${2:-}"

if [[ "$ENVIRONMENT" != "staging" && "$ENVIRONMENT" != "production" ]]; then
    error "Invalid environment: $ENVIRONMENT"
    echo "Usage: $0 [staging|production] [--local-build-only]"
    exit 1
fi

log "Starting deployment for $ENVIRONMENT environment..."

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    error "Flutter is not installed or not in PATH"
    exit 1
fi

# Check if we're in the right directory
if [[ ! -f "$EXAMPLE_DIR/pubspec.yaml" ]]; then
    error "Example app not found at $EXAMPLE_DIR"
    exit 1
fi

cd "$EXAMPLE_DIR"

# Set base href based on environment
if [[ "$ENVIRONMENT" == "production" ]]; then
    BASE_HREF="/flutterish/"
    DEPLOY_URL_VAR="POCKETHOST_PRODUCTION_URL"
    DEPLOY_TOKEN_VAR="POCKETHOST_PRODUCTION_TOKEN"
else
    BASE_HREF="/flutterish-staging/"
    DEPLOY_URL_VAR="POCKETHOST_STAGING_URL"
    DEPLOY_TOKEN_VAR="POCKETHOST_STAGING_TOKEN"
fi

log "Building Flutter web app with WASM support..."
log "Base href: $BASE_HREF"
log "Environment: $ENVIRONMENT"

# Clean previous build
if [[ -d "build/web" ]]; then
    rm -rf build/web
    log "Cleaned previous build"
fi

# Get dependencies
log "Getting Flutter dependencies..."
flutter pub get

# Build the web app
log "Building web app..."
flutter build web --wasm --base-href="$BASE_HREF" --release

if [[ ! -d "build/web" ]]; then
    error "Build failed - no build/web directory found"
    exit 1
fi

success "Build completed successfully!"

# Create deployment info
cat > "build/web/deployment-info.txt" << EOF
Deployment Information
======================
Environment: $ENVIRONMENT
Build Date: $(date)
Git Commit: $(git rev-parse HEAD 2>/dev/null || echo "N/A")
Git Branch: $(git branch --show-current 2>/dev/null || echo "N/A")
Flutter Version: $(flutter --version | head -n 1)
Build Mode: Release
WASM Enabled: Yes
Base Href: $BASE_HREF
EOF

log "Created deployment info file"

# List built files
log "Built files:"
find build/web -name "*.js" -o -name "*.wasm" -o -name "*.html" | head -10

# If local build only, exit here
if [[ "$LOCAL_BUILD_ONLY" == "--local-build-only" ]]; then
    success "Local build completed. Files are in build/web/"
    echo "To serve locally: cd build/web && python -m http.server 8000"
    exit 0
fi

# Check for deployment credentials
DEPLOY_URL="${!DEPLOY_URL_VAR:-}"
DEPLOY_TOKEN="${!DEPLOY_TOKEN_VAR:-}"

if [[ -z "$DEPLOY_URL" || -z "$DEPLOY_TOKEN" ]]; then
    warning "Deployment credentials not found in environment variables"
    warning "Set $DEPLOY_URL_VAR and $DEPLOY_TOKEN_VAR to enable deployment"
    echo ""
    echo "Built files are ready in build/web/"
    echo "You can manually deploy these files to your PocketHost.io instance"
    exit 0
fi

log "Deploying to PocketHost.io..."

# Create deployment package
cd build/web
tar -czf "../deployment-package.tar.gz" .
cd ../..

# Deploy using curl (this is a placeholder - replace with actual PocketHost.io API)
log "Uploading to $ENVIRONMENT environment..."

# This is a placeholder deployment - you'll need to replace this with actual PocketHost.io API calls
if curl -f -X POST "$DEPLOY_URL" \
    -H "Authorization: Bearer $DEPLOY_TOKEN" \
    -F "package=@build/deployment-package.tar.gz" \
    -F "environment=$ENVIRONMENT"; then
    success "Deployment successful!"
    
    if [[ "$ENVIRONMENT" == "production" ]]; then
        echo "🚀 Production deployment: https://flutterish.pockethost.io"
    else
        echo "🚧 Staging deployment: https://flutterish-staging.pockethost.io"
    fi
else
    error "Deployment failed"
    exit 1
fi

# Clean up
rm -f build/deployment-package.tar.gz
log "Cleaned up deployment package"

success "Deployment completed successfully!"