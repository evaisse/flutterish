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

## Example

Check out the [example app](example/) for a complete demonstration of the stepper component.

## Contributing

Contributions are welcome! Please read our contributing guidelines and submit pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
