# PDF Viewer Tests

This directory contains tests for the flutterish_pdf_viewer package.

## Test Files

### flutterish_pdf_viewer_test.dart
Basic unit tests for the PdfController and PdfDocument classes.

### pdf_rendering_test.dart
Golden tests for PDF rendering with the test PDF file (pdf-test.pdf). These tests verify:
- PDF loading from bytes
- PDF viewer widget rendering
- PDF viewer controls
- Different UI states (loading, no document, etc.)

### pdf-test.pdf
A test PDF document (39,762 bytes) used for testing PDF loading and rendering. Note: The file contains 10 pages, but the current implementation renders it as a single page since full PDF parsing is not yet implemented.

## Golden Tests

Golden tests are screenshot-based tests that compare the rendered output of widgets against reference images (golden files). They help ensure that UI changes are intentional and don't introduce visual regressions.

### Running Golden Tests

To run all tests:
```bash
flutter test
```

To run only the PDF rendering golden tests:
```bash
flutter test test/pdf_rendering_test.dart
```

### Updating Golden Files

If you intentionally change the UI and need to update the golden files, run:
```bash
flutter test --update-goldens test/pdf_rendering_test.dart
```

**Important:** Always review the changes in the golden files before committing them to ensure they match your expectations.

### Golden Files Location

Golden files are stored in `test/goldens/` directory:
- `pdf_viewer_from_bytes.png` - PDF viewer loaded from bytes
- `pdf_viewer_with_controller.png` - PDF viewer with controller
- `pdf_viewer_no_controls.png` - PDF viewer without controls
- `pdf_viewer_custom_background.png` - PDF viewer with custom background
- `pdf_viewer_no_document.png` - Empty PDF viewer state

## Test Coverage

The tests cover:
1. **PDF Loading**: Verifying that PDF files can be loaded from bytes
2. **Document Creation**: Testing PdfDocument creation from bytes
3. **Controller Operations**: Testing navigation and state management
4. **Widget Rendering**: Golden tests for visual verification
5. **UI States**: Loading, error, and empty states
6. **Navigation Controls**: Testing page navigation functionality

## Running Tests in CI/CD

Golden tests can be flaky in CI/CD environments due to font rendering differences across platforms. Consider:
1. Using a consistent test environment (e.g., Docker)
2. Setting `FLUTTER_TEST` environment variable
3. Using `flutter test --platform chrome` for web-based testing

## Adding New Tests

When adding new tests:
1. Follow the existing test structure and naming conventions
2. Add appropriate setup/teardown for resource management
3. For golden tests, run with `--update-goldens` first to generate reference images
4. Verify the generated golden files before committing
5. Document the purpose of the test in comments
