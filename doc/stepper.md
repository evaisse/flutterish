# Stepper Component Documentation

## Overview

The `FlutterishStepper` is a highly customizable widget that displays a sequence of steps to guide users through a multi-step process. It supports both vertical and horizontal layouts and provides comprehensive accessibility features.

## API Reference

### FlutterishStepper

The main stepper widget that orchestrates the display of multiple steps.

#### Constructor Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `steps` | `List<StepperStep>` | The list of steps to display | Required |
| `currentStep` | `int` | The index of the currently active step | `0` |
| `onStepTapped` | `ValueChanged<int>?` | Callback when a step is tapped | `null` |
| `type` | `StepperType` | Whether to display vertically or horizontally | `StepperType.vertical` |
| `controlsBuilder` | `ControlsBuilder?` | Builder for custom step controls | `null` |
| `physics` | `ScrollPhysics?` | The scroll physics for the stepper | `null` |
| `margin` | `EdgeInsets?` | The margin around the stepper content | `null` |
| `elevation` | `double?` | The elevation of the stepper | `null` |

### StepperStep

Represents a single step in the stepper.

#### Constructor Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `title` | `Widget` | The title widget for the step | Required |
| `content` | `Widget?` | Optional content displayed when active (vertical mode) | `null` |
| `subtitle` | `Widget?` | Optional subtitle displayed below the title | `null` |
| `state` | `StepState` | The current state of the step | `StepState.indexed` |
| `isActive` | `bool` | Whether this step is currently active | `false` |
| `canTap` | `bool` | Whether this step can be tapped | `true` |

### StepState

Enumeration representing the different states a step can be in:

- `StepState.indexed` - Default state showing step number
- `StepState.complete` - Step has been completed (shows checkmark)
- `StepState.error` - Step has an error (shows X icon)
- `StepState.disabled` - Step is disabled (grayed out)
- `StepState.editing` - Step is being edited (shows edit icon)

### StepperType

Enumeration for stepper layout:

- `StepperType.vertical` - Steps are arranged vertically
- `StepperType.horizontal` - Steps are arranged horizontally

## Theming

### StepperThemeData

Comprehensive theming options for customizing the stepper appearance:

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `activeStepColor` | `Color?` | Color for active steps |
| `inactiveStepColor` | `Color?` | Color for inactive steps |
| `completeStepColor` | `Color?` | Color for completed steps |
| `errorStepColor` | `Color?` | Color for steps with errors |
| `disabledStepColor` | `Color?` | Color for disabled steps |
| `editingStepColor` | `Color?` | Color for steps being edited |
| `connectorColor` | `Color?` | Color for connector lines |
| `activeStepTitleStyle` | `TextStyle?` | Text style for active step titles |
| `inactiveStepTitleStyle` | `TextStyle?` | Text style for inactive step titles |
| `stepSubtitleStyle` | `TextStyle?` | Text style for step subtitles |
| `iconSize` | `double` | Size of step icons (default: 24.0) |
| `connectorHeight` | `double` | Height of connectors (default: 24.0) |
| `stepPadding` | `EdgeInsets` | Padding around each step (default: 8.0 all) |
| `iconSpacing` | `double` | Spacing between icon and content (default: 12.0) |
| `margin` | `EdgeInsets?` | Margin around entire stepper |
| `elevation` | `double` | Elevation of the stepper (default: 0.0) |

### Using StepperTheme

Wrap your stepper with `StepperTheme` to apply custom styling:

```dart
StepperTheme(
  data: StepperThemeData(
    activeStepColor: Colors.purple,
    completeStepColor: Colors.green,
    iconSize: 28.0,
    elevation: 4.0,
  ),
  child: FlutterishStepper(
    steps: mySteps,
  ),
)
```

## Accessibility Features

The stepper component is built with accessibility in mind:

### Screen Reader Support
- Each step icon includes semantic labels indicating step number and state
- States are announced (e.g., "Step 1, completed", "Step 2, has error")
- Interactive elements are properly marked

### Keyboard Navigation
- Steps can be focused and activated using keyboard
- Proper focus management between steps
- Support for arrow key navigation (when enabled)

### Best Practices

1. **Provide descriptive titles**: Use clear, concise titles for each step
2. **Use appropriate states**: Set correct `StepState` values to communicate progress
3. **Handle errors gracefully**: Use `StepState.error` and provide clear error messages
4. **Test with screen readers**: Verify accessibility with tools like TalkBack/VoiceOver

## Examples

### Basic Vertical Stepper

```dart
FlutterishStepper(
  steps: [
    StepperStep(
      title: Text('Choose Plan'),
      content: Text('Select your subscription plan'),
    ),
    StepperStep(
      title: Text('Payment'),
      content: Text('Enter payment information'),
      state: StepState.indexed,
    ),
    StepperStep(
      title: Text('Confirmation'),
      state: StepState.disabled,
    ),
  ],
  currentStep: 0,
)
```

### Horizontal Stepper with Custom Theme

```dart
StepperTheme(
  data: StepperThemeData(
    activeStepColor: Colors.blue,
    completeStepColor: Colors.green,
    connectorColor: Colors.blue.shade200,
  ),
  child: FlutterishStepper(
    type: StepperType.horizontal,
    steps: [
      StepperStep(
        title: Text('Cart'),
        state: StepState.complete,
      ),
      StepperStep(
        title: Text('Shipping'),
        state: StepState.indexed,
      ),
      StepperStep(
        title: Text('Payment'),
        state: StepState.indexed,
      ),
    ],
    currentStep: 1,
    onStepTapped: (step) {
      // Navigate to step
    },
  ),
)
```

### Error Handling

```dart
FlutterishStepper(
  steps: [
    StepperStep(
      title: Text('Validation Failed'),
      subtitle: Text('Please fix the errors below'),
      content: Text('Email address is required'),
      state: StepState.error,
    ),
  ],
  currentStep: 0,
)
```