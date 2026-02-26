import 'package:flutter/material.dart';
import 'package:flutterish_pdf_viewer/flutterish_pdf_viewer.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

/// Example showing how to load a PDF from assets
class AssetPdfExample extends StatefulWidget {
  const AssetPdfExample({Key? key}) : super(key: key);

  @override
  State<AssetPdfExample> createState() => _AssetPdfExampleState();
}

class _AssetPdfExampleState extends State<AssetPdfExample> {
  final PdfController _controller = PdfController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAssetPdf();
  }

  Future<void> _loadAssetPdf() async {
    try {
      // Load PDF from assets
      final ByteData data = await rootBundle.load('assets/sample.pdf');
      final Uint8List bytes = data.buffer.asUint8List();

      await _controller.loadFromBytes(bytes);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading PDF: $e')),
        );
      }
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
        title: const Text('Asset PDF Example'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PdfViewer(
              controller: _controller,
              showControls: true,
            ),
    );
  }
}
