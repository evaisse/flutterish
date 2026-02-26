# flutterish_pdf_viewer

A PDF viewer in Flutter that does not require any external native dependencies.

## 🌐 Live Demo

**[Try the live demo here!](https://evaisse.github.io/flutterish_pdf_viewer/)**

The demo showcases all features of the library including:
- Loading PDFs from URLs
- Custom navigation controls
- Download functionality
- Loading from bytes/assets
- And more!

See [DEMO_FEATURES.md](DEMO_FEATURES.md) for a detailed breakdown of all demonstrated features.

## Features

- 📱 Pure Flutter/Dart implementation - no native code required
- 🌐 Load PDFs from URLs
- 📄 Load PDFs from bytes/local files
- 💾 Download PDFs to device storage
- 📑 Page navigation controls
- 🎨 Customizable viewer appearance

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutterish_pdf_viewer: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage with URL

```dart
import 'package:flutter/material.dart';
import 'package:flutterish_pdf_viewer/flutterish_pdf_viewer.dart';

class MyPdfViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Viewer')),
      body: PdfViewerFromUrl(
        url: 'https://example.com/sample.pdf',
        showControls: true,
        onLoaded: () => print('PDF loaded successfully'),
        onError: (error) => print('Error: $error'),
      ),
    );
  }
}
```

### Advanced Usage with Controller

```dart
import 'package:flutter/material.dart';
import 'package:flutterish_pdf_viewer/flutterish_pdf_viewer.dart';

class AdvancedPdfViewer extends StatefulWidget {
  @override
  _AdvancedPdfViewerState createState() => _AdvancedPdfViewerState();
}

class _AdvancedPdfViewerState extends State<AdvancedPdfViewer> {
  final PdfController _controller = PdfController();

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    await _controller.loadFromUrl('https://example.com/sample.pdf');
  }

  Future<void> _downloadPdf() async {
    final path = await _controller.downloadPdf('my_document.pdf');
    if (path != null) {
      print('PDF saved to: $path');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadPdf,
          ),
        ],
      ),
      body: PdfViewer(
        controller: _controller,
        showControls: true,
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
```

### Loading from Bytes

```dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutterish_pdf_viewer/flutterish_pdf_viewer.dart';

class BytesPdfViewer extends StatelessWidget {
  final Uint8List pdfBytes;

  const BytesPdfViewer({required this.pdfBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF from Bytes')),
      body: PdfViewerFromBytes(
        bytes: pdfBytes,
        showControls: true,
      ),
    );
  }
}
```

## API Reference

### PdfViewer

The main widget for displaying PDF documents.

**Properties:**
- `controller` (required): PdfController instance managing the document
- `showControls` (optional): Whether to show page navigation controls (default: true)
- `backgroundColor` (optional): Background color for the viewer

### PdfController

Controller for managing PDF documents and navigation.

**Methods:**
- `loadFromUrl(String url)`: Load a PDF from a URL
- `loadFromBytes(Uint8List bytes)`: Load a PDF from bytes
- `downloadPdf(String filename)`: Download the current PDF to device storage
- `goToPage(int page)`: Navigate to a specific page
- `nextPage()`: Navigate to the next page
- `previousPage()`: Navigate to the previous page

**Properties:**
- `document`: The current PDF document
- `isLoading`: Whether a document is currently loading
- `error`: Any error message from the last operation
- `currentPage`: The current page number (0-indexed)

### PdfViewerFromUrl

Convenience widget for loading PDFs directly from a URL.

**Properties:**
- `url` (required): The URL of the PDF to load
- `showControls` (optional): Whether to show page navigation controls
- `onLoaded` (optional): Callback when the PDF is successfully loaded
- `onError` (optional): Callback when an error occurs

### PdfViewerFromBytes

Convenience widget for loading PDFs from bytes.

**Properties:**
- `bytes` (required): The PDF bytes to load
- `showControls` (optional): Whether to show page navigation controls

## Example

Check out the [example](example) directory for a complete sample application.

**Live Demo:** [https://evaisse.github.io/flutterish_pdf_viewer/](https://evaisse.github.io/flutterish_pdf_viewer/)

To run the example locally:

```bash
cd example
flutter run
```

To run on web:

```bash
cd example
flutter run -d chrome
```

### Deploying Your Own Demo

Want to deploy your own version? See [GITHUB_PAGES_SETUP.md](GITHUB_PAGES_SETUP.md) for instructions on setting up GitHub Pages for this demo.

## Limitations

**Note:** This package currently provides a framework for PDF viewing without native dependencies. Full PDF rendering (displaying actual PDF content as rendered pages) requires a PDF parsing and rendering library. The current implementation displays PDF metadata and provides the infrastructure for:

- Loading PDFs from various sources
- Navigation between pages
- Downloading PDFs
- Managing PDF state

For complete PDF rendering, you may need to:
1. Implement a pure Dart PDF parser
2. Use an existing PDF rendering library
3. Convert PDFs to images on a backend server

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Created by [evaisse](https://github.com/evaisse)
