# Flutterish PDF Viewer - Demo App

This is a demonstration Flutter web application showcasing all the features of the **Flutterish PDF Viewer** package.

## 🌐 Live Demo

**Visit the live demo at: [https://evaisse.github.io/flutterish_pdf_viewer/](https://evaisse.github.io/flutterish_pdf_viewer/)**

## Overview

This example demonstrates how to use the flutterish_pdf_viewer package.

## Features Demonstrated

### Main Demo (`lib/main.dart`)
- Loading PDF from URL
- Basic viewer with built-in controls
- Download functionality

### Additional Examples (`lib/examples/`)

#### Asset PDF Example (`asset_pdf_example.dart`)
- Load PDF from app assets
- Handle loading states
- Error handling

#### Custom Controls Example (`custom_controls_example.dart`)
- Custom navigation controls
- Styled UI components
- Advanced controller usage

## Running the Example

### Web (Recommended for Demo)

```bash
flutter pub get
flutter run -d chrome
```

### Mobile/Desktop

```bash
flutter pub get
flutter run
```

### Building for Production

```bash
flutter build web --release
```

The output will be in `build/web/`.

## Code Examples

### Loading from URL

```dart
final controller = PdfController();
await controller.loadFromUrl('https://example.com/sample.pdf');
```

### Loading from Bytes

```dart
final ByteData data = await rootBundle.load('assets/sample.pdf');
final Uint8List bytes = data.buffer.asUint8List();
await controller.loadFromBytes(bytes);
```

### Downloading PDF

```dart
final path = await controller.downloadPdf('my_document.pdf');
print('PDF saved to: $path');
```

### Navigation

```dart
// Go to next page
controller.nextPage();

// Go to previous page
controller.previousPage();

// Go to specific page
controller.goToPage(5);
```

## Widgets

### PdfViewer
Main viewer widget with customizable options.

### PdfViewerFromUrl
Convenience widget for loading from URL.

### PdfViewerFromBytes
Convenience widget for loading from bytes.

## Testing

To test with different PDFs, you can use:
- https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf (small test file)
- https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf (sample with content)

## Notes

The current implementation provides a framework for PDF viewing. Full PDF rendering requires additional parsing and rendering capabilities.
