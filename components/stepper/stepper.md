# Stepper Component

The `FlutterishStepper` is a flexible and customizable widget that displays a sequence of steps to guide users through a process. It supports both vertical and horizontal layouts and provides extensive styling options.

## Features

- **Vertical and Horizontal Layouts**: Choose the layout that best fits your design.
- **Customizable Styling**: Fully customize colors, fonts, and dimensions via `StepperTheme`.
- **Flexible Content**: Add any widget as content for each step.
- **Interactive Steps**: Handle taps on steps and manage step state (complete, error, disabled, etc.).
- **Accessibility**: Includes semantic labels for better accessibility.

## Usage

Import the package:

```dart
import 'package:flutterish/flutterish.dart';
```

### Basic Usage

```dart
FlutterishStepper(
  currentStep: _currentStep,
  onStepTapped: (index) {
    setState(() {
      _currentStep = index;
    });
  },
  steps: [
    StepperStep(
      title: Text('Step 1'),
      content: Text('Content for Step 1'),
    ),
    StepperStep(
      title: Text('Step 2'),
      content: Text('Content for Step 2'),
    ),
    StepperStep(
      title: Text('Step 3'),
      content: Text('Content for Step 3'),
    ),
  ],
)
```

### Horizontal Layout

To use a horizontal layout, set the `type` parameter to `StepperType.horizontal`:

```dart
FlutterishStepper(
  type: StepperType.horizontal,
  currentStep: _currentStep,
  steps: [
    // ... steps
  ],
)
```

### Step States

Each step can have a specific state:

```dart
StepperStep(
  title: Text('Error Step'),
  state: StepState.error,
  content: Text('Fix the error here'),
),
StepperStep(
  title: Text('Completed Step'),
  state: StepState.complete,
),
```

Available states:
- `StepState.indexed`: Default state, shows the step index.
- `StepState.editing`: Shows an edit icon.
- `StepState.complete`: Shows a checkmark icon.
- `StepState.disabled`: Greys out the step.
- `StepState.error`: Shows an error icon and red color.

## Customization

You can wrap the `FlutterishStepper` in a `StepperTheme` to customize its appearance:

```dart
StepperTheme(
  data: StepperThemeData(
    activeStepColor: Colors.purple,
    completeStepColor: Colors.green,
    iconSize: 32,
    // ... other properties
  ),
  child: FlutterishStepper(
    // ...
  ),
)
```

## API Reference

### FlutterishStepper

| Parameter | Type | Description |
|---|---|---|
| `steps` | `List<StepperStep>` | The list of steps to display. |
| `currentStep` | `int` | The index of the currently active step. |
| `onStepTapped` | `ValueChanged<int>?` | Called when a step is tapped. |
| `type` | `StepperType` | Layout type: `vertical` or `horizontal`. |
| `controlsBuilder` | `ControlsBuilder?` | Builder for custom step controls. |
| `physics` | `ScrollPhysics?` | The scroll physics for the stepper. |
| `margin` | `EdgeInsets?` | The margin around the stepper content. |
| `elevation` | `double?` | The elevation of the stepper. |

### StepperStep

| Parameter | Type | Description |
|---|---|---|
| `title` | `Widget` | The title of the step. |
| `subtitle` | `Widget?` | The subtitle of the step. |
| `content` | `Widget?` | The content of the step. |
| `state` | `StepState` | The state of the step. |
| `isActive` | `bool` | Whether the step is active. |

### StepperThemeData

Properties available for customization in `StepperThemeData`:

- `activeStepColor`
- `inactiveStepColor`
- `completeStepColor`
- `editingStepColor`
- `errorStepColor`
- `disabledStepColor`
- `activeStepTitleStyle`
- `inactiveStepTitleStyle`
- `stepSubtitleStyle`
- `iconSize`
- `iconSpacing`
- `connectorColor`
- `connectorHeight`
- `stepPadding`
- `margin`
- `elevation`
