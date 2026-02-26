import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'pdf_controller.dart';

/// A widget that displays PDF documents without native dependencies
class PdfViewer extends StatefulWidget {
  /// The PDF controller managing the document
  final PdfController controller;

  /// Whether to show page navigation controls
  final bool showControls;

  /// Background color for the viewer
  final Color? backgroundColor;

  const PdfViewer({
    super.key,
    required this.controller,
    this.showControls = true,
    this.backgroundColor,
  });

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerUpdate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerUpdate);
    super.dispose();
  }

  void _onControllerUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Colors.grey[300],
      child: widget.controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.controller.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        widget.controller.error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : widget.controller.document != null
                  ? Column(
                      children: [
                        Expanded(
                          child: _buildPdfContent(),
                        ),
                        if (widget.showControls) _buildControls(),
                      ],
                    )
                  : const Center(
                      child: Text('No PDF loaded'),
                    ),
    );
  }

  Widget _buildPdfContent() {
    // For a pure Flutter implementation, we display the PDF bytes
    // In a real implementation, you would:
    // 1. Parse the PDF structure
    // 2. Render each page using Flutter widgets
    // 3. Handle text, images, and vector graphics

    // This is a placeholder that shows PDF metadata
    final document = widget.controller.document!;
    final bytes = document.bytes;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.picture_as_pdf, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              'PDF Document Loaded',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Size: ${bytes.length} bytes'),
            Text(
                'Current Page: ${widget.controller.currentPage + 1} / ${document.pageCount}'),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Note: Full PDF rendering requires a PDF parser. '
                'This viewer currently displays PDF metadata. '
                'For full rendering, consider using a PDF parsing library.',
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: widget.controller.currentPage > 0
                ? widget.controller.previousPage
                : null,
          ),
          Text(
            'Page ${widget.controller.currentPage + 1} / ${widget.controller.document?.pageCount ?? 0}',
            style: const TextStyle(color: Colors.white),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: widget.controller.document != null &&
                    widget.controller.currentPage <
                        widget.controller.document!.pageCount - 1
                ? widget.controller.nextPage
                : null,
          ),
        ],
      ),
    );
  }
}

/// A simple PDF viewer that loads from a URL
class PdfViewerFromUrl extends StatefulWidget {
  /// The URL of the PDF to load
  final String url;

  /// Whether to show page navigation controls
  final bool showControls;

  /// Callback when the PDF is successfully loaded
  final VoidCallback? onLoaded;

  /// Callback when an error occurs
  final void Function(String error)? onError;

  const PdfViewerFromUrl({
    super.key,
    required this.url,
    this.showControls = true,
    this.onLoaded,
    this.onError,
  });

  @override
  State<PdfViewerFromUrl> createState() => _PdfViewerFromUrlState();
}

class _PdfViewerFromUrlState extends State<PdfViewerFromUrl> {
  late PdfController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PdfController();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    await _controller.loadFromUrl(widget.url);
    if (_controller.error != null && widget.onError != null) {
      widget.onError!(_controller.error!);
    } else if (_controller.document != null && widget.onLoaded != null) {
      widget.onLoaded!();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PdfViewer(
      controller: _controller,
      showControls: widget.showControls,
    );
  }
}

/// A simple PDF viewer that loads from bytes
class PdfViewerFromBytes extends StatefulWidget {
  /// The PDF bytes to load
  final Uint8List bytes;

  /// Whether to show page navigation controls
  final bool showControls;

  const PdfViewerFromBytes({
    super.key,
    required this.bytes,
    this.showControls = true,
  });

  @override
  State<PdfViewerFromBytes> createState() => _PdfViewerFromBytesState();
}

class _PdfViewerFromBytesState extends State<PdfViewerFromBytes> {
  late PdfController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PdfController();
    _controller.loadFromBytes(widget.bytes);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PdfViewer(
      controller: _controller,
      showControls: widget.showControls,
    );
  }
}
