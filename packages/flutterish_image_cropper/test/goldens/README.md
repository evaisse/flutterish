# Golden Test Files

This directory contains golden images for widget tests. Golden tests help ensure that UI changes are intentional and visible.

## What are Golden Tests?

Golden tests (also called snapshot tests) compare the current rendering of a widget against a reference image (the "golden" file). If the widget's appearance changes, the test will fail, alerting developers to the change.

## Initial Setup

The first time you set up the project, you'll need to generate the golden files:

```bash
# Generate all golden files for the first time
flutter test --update-goldens
```

This will create the reference images in the `test/goldens/` directory. Make sure to commit these files to the repository.

## Updating Golden Files

When you intentionally change the UI or the golden test fails due to expected changes, you can update the golden files:

```bash
# Update all golden files
flutter test --update-goldens

# Update specific test file
flutter test --update-goldens test/image_cropper_golden_test.dart
```

## Running Golden Tests

```bash
# Run all tests including golden tests
flutter test

# Run only golden tests
flutter test test/image_cropper_golden_test.dart
```

## CI/CD

Golden tests run automatically in CI. If they fail:

1. Review the failure artifacts in the GitHub Actions workflow
2. Determine if the change is intentional
3. If intentional, update the golden files locally and commit them
4. If unintentional, fix the code to match the expected UI

## Best Practices

- Keep golden files small (use reasonable widget sizes in tests)
- Don't test dynamic content (use mock data with fixed values)
- Review golden file changes carefully in PRs
- Update goldens when making intentional UI changes
