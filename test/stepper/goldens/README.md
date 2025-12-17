# Golden Test Files

This directory contains golden test images for the FlutterishStepper widget.

## Current Status

The golden files in this directory are **placeholder images** created to fix initial CI failures. They need to be regenerated with actual widget screenshots.

## How to Regenerate Golden Files

To regenerate the golden files with actual widget screenshots, run:

```bash
flutter test --update-goldens test/stepper/stepper_golden_test.dart
```

This will:
1. Run the golden tests
2. Capture screenshots of the rendered widgets
3. Update the PNG files in this directory with the actual screenshots

## When to Regenerate

Regenerate golden files whenever:
- The visual appearance of the stepper widget changes intentionally
- The theme or styling is modified
- The layout or rendering logic is updated
- You're setting up the project for the first time

## Files

- `vertical_stepper.png` - Vertical stepper with different step states
- `horizontal_stepper.png` - Horizontal stepper layout
- `themed_stepper.png` - Stepper with custom theme applied
