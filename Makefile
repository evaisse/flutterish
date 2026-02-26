PACKAGES := packages/flutterish_stepper packages/flutterish_a2ui packages/flutterish_a2ui_standard packages/flutterish_image_cropper packages/flutterish_pdf_viewer packages/flutterish

.PHONY: help install analyze test test-update-goldens format clean publish-dry-run

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-22s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies for all packages
	flutter pub get

analyze: ## Run static analysis on all packages
	@for pkg in $(PACKAGES) example; do \
		echo "\n\033[36m▸ Analyzing $$pkg\033[0m"; \
		cd $$pkg && flutter analyze && cd $(CURDIR); \
	done

test: ## Run tests for all packages
	@for pkg in $(PACKAGES); do \
		if [ -d "$$pkg/test" ]; then \
			echo "\n\033[36m▸ Testing $$pkg\033[0m"; \
			cd $$pkg && flutter test && cd $(CURDIR); \
		fi \
	done

test-update-goldens: ## Update golden files for all packages
	@for pkg in $(PACKAGES); do \
		if [ -d "$$pkg/test" ]; then \
			echo "\n\033[36m▸ Updating goldens in $$pkg\033[0m"; \
			cd $$pkg && flutter test --update-goldens && cd $(CURDIR); \
		fi \
	done

format: ## Format all Dart files
	dart format .

clean: ## Clean build artifacts for all packages
	@for pkg in $(PACKAGES) example; do \
		echo "\n\033[36m▸ Cleaning $$pkg\033[0m"; \
		cd $$pkg && flutter clean && cd $(CURDIR); \
	done
	@rm -rf .dart_tool build

publish-dry-run: ## Dry-run publish check for all publishable packages
	@for pkg in $(PACKAGES); do \
		echo "\n\033[36m▸ Publish dry-run: $$pkg\033[0m"; \
		cd $$pkg && flutter pub publish --dry-run && cd $(CURDIR); \
	done

build-example-web: ## Build the example app for web (WASM)
	cd example && flutter build web --wasm --release
