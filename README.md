# Flutterish

Flutterish is a collection of re-usable Flutter widgets, designed to be lightweight with minimal dependencies.

## Components

### Stepper

A customizable stepper component that guides users through multi-step processes.

#### Features

- **Vertical and Horizontal Layouts**: Choose between vertical or horizontal step progression
- **Customizable Step States**: Support for indexed, complete, error, disabled, and editing states
- **Accessibility First**: Built-in screen reader support and keyboard navigation
- **Themeable**: Extensive theming support through `StepperTheme`
- **Interactive**: Optional step tapping with callback support

#### Basic Usage

```dart
import 'package:flutterish/flutterish.dart';

FlutterishStepper(
  steps: [
    StepperStep(
      title: Text('Account Setup'),
      subtitle: Text('Create your account'),
      content: Text('Fill in your account details...'),
    ),
    StepperStep(
      title: Text('Profile'),
      subtitle: Text('Personal information'),
      state: StepState.complete,
    ),
    StepperStep(
      title: Text('Verification'),
      subtitle: Text('Verify your email'),
      state: StepState.error,
    ),
  ],
  currentStep: 0,
  onStepTapped: (step) {
    // Handle step navigation
  },
)
```

#### Theming

Customize the appearance using `StepperTheme`:

```dart
StepperTheme(
  data: StepperThemeData(
    activeStepColor: Colors.blue,
    completeStepColor: Colors.green,
    errorStepColor: Colors.red,
    iconSize: 28.0,
    elevation: 4.0,
  ),
  child: FlutterishStepper(
    // ... your stepper configuration
  ),
)
```

#### Accessibility

The stepper component includes:

- Semantic labels for screen readers
- Keyboard navigation support
- Focus management
- State announcements (completed, error, etc.)

## Installation

Add flutterish to your `pubspec.yaml`:

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

## 🎯 Component Roadmap

We're building a comprehensive component library inspired by popular UI frameworks. Check our [GitHub Issues](https://github.com/evaisse/flutterish/issues) for the full list of planned components from:

- Material UI (MUI)
- Framework7

### Generating Component Issues

To automatically create GitHub issues for components from MUI and Framework7:

```bash
cd scripts/component-scraper
npm install
npm run scrape
npm run create-issues
```

See [scripts/component-scraper/README.md](scripts/component-scraper/README.md) for detailed instructions.

You can also use the GitHub Actions workflow "Create Component Issues" to automate this process.

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
- # [Golden Testing in Flutter](https://flutter.dev/docs/testing/unit-testing#golden-file-testing)

## Example

Check out the [example app](example/) for a complete demonstration of the stepper component.

## Contributing

Contributions are welcome! Please read our contributing guidelines and submit pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
