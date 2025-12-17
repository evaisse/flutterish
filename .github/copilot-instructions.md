# Copilot Instructions for Flutterish

This document provides guidance for GitHub Copilot when working on the Flutterish repository.

## Project Overview

Flutterish is a Flutter component library focused on providing lightweight, reusable widgets with minimal dependencies. The library emphasizes accessibility, theming, and clean component design.

## Technology Stack

- **Framework**: Flutter (v3.35.5+)
- **Language**: Dart (SDK ^3.9.0)
- **Primary Components**: Currently includes a customizable Stepper widget
- **Testing**: Unit tests, widget tests, and golden tests
- **Linting**: flutter_lints ^5.0.0
- **Platforms**: Native (iOS, Android, macOS) and Web (including WASM)

## Build and Test Commands

### Setup and Dependencies
```bash
# Install dependencies for main package
flutter pub get

# Install dependencies for example app
cd example && flutter pub get
```

### Analysis and Linting
```bash
# Analyze main package
flutter analyze

# Analyze example app
cd example && flutter analyze
```

### Testing
```bash
# Run all tests
flutter test

# Run golden tests (searches for tests with 'golden' in the name)
flutter test --name golden

# Update golden files
flutter test --update-goldens

# Run tests for example app
cd example && flutter test
```

### Building
```bash
# Build example app for web
cd example && flutter build web --wasm --release

# Run example app
cd example && flutter run

# Run example app on specific platform
cd example && flutter run -d chrome     # Web
cd example && flutter run -d macos      # macOS
cd example && flutter run -d ios        # iOS
```

## Code Conventions

### General Rules

1. **Language**: Always use English for code and documentation
2. **File Structure**: Create small, focused components and files instead of large files
3. **Dependencies**: Keep dependencies minimal - the library should remain lightweight
4. **Code Style**: Follow Flutter and Dart conventions as enforced by flutter_lints

### Component Design

1. **Theming**: Make widgets configurable using theme extensions
   - Create dedicated theme classes (e.g., `StepperTheme`, `StepperThemeData`)
   - Support inheritance and customization
   - Provide sensible defaults

2. **Accessibility**: Every component must be accessible
   - Use `Semantics` widget for screen reader support
   - Provide semantic labels and hints
   - Support keyboard navigation
   - Test with screen readers

3. **Layout**: Design for mobile-first
   - Support both vertical and horizontal layouts where applicable
   - Ensure components work well in small viewports
   - Make responsive where appropriate

4. **State Management**: 
   - Use StatefulWidget or StatelessWidget as appropriate
   - For dependency injection, use InheritedWidget patterns
   - Keep state local to components when possible

### Testing Requirements

1. **Unit Tests**: Required for all business logic
2. **Widget Tests**: Required for all components
   - Test different states and configurations
   - Test user interactions
   - Test accessibility features

3. **Golden Tests**: Required for visual components
   - Create golden tests for all visual states
   - Update goldens when intentionally changing UI
   - Use meaningful test names

4. **Test Organization**:
   - Place tests in `test/` directory mirroring `lib/` structure
   - Golden tests are co-located with other tests (e.g., `test/stepper/stepper_golden_test.dart`)
   - Use descriptive test names and groups
   - Name golden tests with `_golden_test.dart` suffix for easy identification

### Documentation

1. **Code Documentation**:
   - Document all public APIs with dartdoc comments
   - Include usage examples in documentation
   - Explain parameters and return values

2. **README Updates**: Update README.md when:
   - Adding new components
   - Changing API
   - Adding features

3. **Examples**: 
   - Provide working examples in `example/` directory
   - Keep examples simple and focused
   - Demonstrate key features

## Security Guidelines

1. Follow OWASP best practices
2. Never commit secrets or credentials
3. Validate user inputs appropriately
4. Be cautious with external dependencies
5. Review security implications of code changes

## Git Workflow

1. **Branches**: Always work in feature branches, never directly in main/master
2. **Commits**: Write clear, descriptive commit messages
3. **Pull Requests**: 
   - Keep PRs focused and small
   - Include tests for all changes
   - Update documentation as needed

## CI/CD

The repository uses GitHub Actions for:
- **Build and Test**: Runs on push and PR (flutter analyze + flutter test)
- **Deploy Staging**: Deploys example app to staging environment
- **Deploy Production**: Deploys example app to production
- **Deploy GitHub Pages**: Publishes documentation

Ensure all CI checks pass before merging.

## Common Tasks

### Adding a New Component

1. Create component file in `lib/src/`
2. Export in `lib/flutterish.dart`
3. Create theme class if customization needed
4. Add comprehensive tests (unit, widget, golden)
5. Update README.md with usage examples
6. Add example in `example/` directory
7. Ensure accessibility features are implemented

### Fixing a Bug

1. Add a failing test that reproduces the bug
2. Fix the bug with minimal code changes
3. Ensure all tests pass
4. Update documentation if behavior changed

### Refactoring

1. Ensure test coverage exists first
2. Make incremental changes
3. Run tests frequently
4. Consider backward compatibility
5. Check for unused code and remove it

## File Structure

```
flutterish/
├── lib/
│   ├── flutterish.dart           # Main export file
│   └── src/                      # Implementation files
│       ├── stepper/              # Stepper component
│       └── [other components]/
├── test/
│   ├── stepper/                  # Stepper tests
│   │   ├── stepper_widget_test.dart   # Widget tests
│   │   └── stepper_golden_test.dart   # Golden tests
│   └── flutterish_test.dart      # Main test file
├── example/                      # Example app
├── doc/                          # Documentation
└── scripts/                      # Utility scripts
```

## Notes

- This is a package (library), not an application
- Focus on reusability and composability
- Keep the API surface small and clean
- Prioritize quality over quantity of features
- When in doubt, refer to Flutter's Material and Cupertino libraries for inspiration
