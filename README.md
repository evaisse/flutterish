# Flutterish

A comprehensive Flutter UI kit providing a complete collection of customizable widgets and components for building beautiful, accessible, and responsive Flutter applications.

## 🏗️ Project Structure

This project uses a **monorepo workspace structure** to organize code efficiently:

```
flutterish/
├── packages/                    # Individual UI component packages
│   └── flutterish_sandbox/     # Core UI components package
├── example/                     # Multi-platform demo application
├── lib/                        # Meta-package exports
└── test/                       # Main package tests
```

### Packages

- **Main Package** (`/`): Meta-package that re-exports all UI components
- **Component Packages** (`/packages/*`): Individual packages containing specific UI components
- **Demo App** (`/example`): Multi-platform demonstration application

## 🚀 Demo Application

The `/example` directory contains a **multi-platform Flutter application** that showcases all available widgets and their capabilities across:

- 📱 **Mobile** (iOS & Android)
- 🖥️ **Desktop** (Windows, macOS, Linux)
- 🌐 **Web**

The demo app serves as both documentation and testing ground for the entire UI kit.

## 🧪 Testing Strategy

### Golden Testing

This project emphasizes **extensive UI testing** using Flutter's golden testing framework, with a focus on:

- **Mobile Viewports**: Primary testing target for responsive design
- **Visual Regression**: Ensuring UI consistency across updates
- **Cross-Platform Compatibility**: Testing widgets across different platforms
- **Accessibility**: Ensuring proper semantics and screen reader support

Golden tests capture widget snapshots and compare them against reference images to catch visual regressions automatically.

### Test Structure

- Unit tests for component logic
- Widget tests for UI behavior
- Golden tests for visual consistency
- Integration tests in the demo app

## 🎨 Features

- **Complete UI Kit**: Comprehensive collection of Flutter widgets
- **Accessibility First**: Built with accessibility in mind using Semantics widgets
- **Theme Extensions**: Configurable widgets using Flutter theme extensions
- **Mobile-Optimized**: Clean, small UI elements optimized for mobile viewports
- **Cross-Platform**: Compatible with all Flutter-supported platforms
- **Minimal Dependencies**: Designed to minimize external dependencies

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutterish: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## 🔧 Usage

```dart
import 'package:flutterish/flutterish.dart';

// Use any component from the UI kit
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            // Flutterish components will be available here
          ],
        ),
      ),
    );
  }
}
```

## 🏃‍♂️ Running the Demo

To see all components in action:

```bash
cd example
flutter run
```

Choose your target platform:
- `flutter run -d chrome` for web
- `flutter run -d macos` for macOS
- `flutter run -d ios` for iOS simulator

## 🧪 Running Tests

```bash
# Run all tests
flutter test

# Run golden tests specifically
flutter test --update-goldens  # Update golden files
flutter test test/golden/      # Run golden tests only
```

## 🤝 Contributing

1. Follow the project conventions outlined in `AGENTS.md`
2. Create small, focused components
3. Include comprehensive tests, especially golden tests
4. Ensure accessibility compliance
5. Update documentation as needed

## 📄 License

This project is licensed under the terms specified in the LICENSE file.

## 🔗 Related

- [Flutter Documentation](https://flutter.dev/docs)
- [Flutter Accessibility Guide](https://flutter.dev/docs/development/accessibility-and-semantics)
- [Golden Testing in Flutter](https://flutter.dev/docs/testing/unit-testing#golden-file-testing)
