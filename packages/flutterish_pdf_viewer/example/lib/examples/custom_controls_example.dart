import 'package:flutter/material.dart';
import 'package:flutterish_pdf_viewer/flutterish_pdf_viewer.dart';

/// Example showing custom PDF viewer with additional controls
class CustomControlsExample extends StatefulWidget {
  const CustomControlsExample({Key? key}) : super(key: key);

  @override
  State<CustomControlsExample> createState() => _CustomControlsExampleState();
}

class _CustomControlsExampleState extends State<CustomControlsExample> {
  final PdfController _controller = PdfController();
  final TextEditingController _urlController = TextEditingController(
    text:
        'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
  );

  @override
  void dispose() {
    _controller.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _loadPdf() {
    final url = _urlController.text.trim();
    if (url.isNotEmpty) {
      _controller.loadFromUrl(url);
    }
  }

  Future<void> _downloadPdf() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final filename = 'pdf_$timestamp.pdf';
    final path = await _controller.downloadPdf(filename);

    if (path != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF downloaded to: $path'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Controls Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPdf,
            tooltip: 'Reload PDF',
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _controller.document != null ? _downloadPdf : null,
            tooltip: 'Download PDF',
          ),
        ],
      ),
      body: Column(
        children: [
          // URL input
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(
                      labelText: 'PDF URL',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSubmitted: (_) => _loadPdf(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _loadPdf,
                  icon: const Icon(Icons.cloud_download),
                  label: const Text('Load'),
                ),
              ],
            ),
          ),
          // PDF viewer without built-in controls
          Expanded(
            child: PdfViewer(
              controller: _controller,
              showControls: false,
              backgroundColor: Colors.white,
            ),
          ),
          // Custom controls
          _buildCustomControls(),
        ],
      ),
    );
  }

  Widget _buildCustomControls() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.blue[900],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous page button
          ElevatedButton.icon(
            onPressed:
                _controller.currentPage > 0 ? _controller.previousPage : null,
            icon: const Icon(Icons.chevron_left),
            label: const Text('Previous'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
            ),
          ),
          // Page indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Page ${_controller.currentPage + 1} / ${_controller.document?.pageCount ?? 0}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          // Next page button
          ElevatedButton.icon(
            onPressed: _controller.document != null &&
                    _controller.currentPage <
                        _controller.document!.pageCount - 1
                ? _controller.nextPage
                : null,
            icon: const Icon(Icons.chevron_right),
            label: const Text('Next'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }
}
