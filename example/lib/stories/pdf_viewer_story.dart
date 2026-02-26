import 'package:flutter/material.dart';
import 'package:flutterish/flutterish.dart';

class PdfViewerStory extends StatelessWidget {
  const PdfViewerStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer Demo')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Le PDF Viewer permet de visualiser des documents.'),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: PdfViewerFromUrl(
                  url: 'https://raw.githubusercontent.com/mozilla/pdf.js/ba2edeae/web/compressed.tracemonkey-pldi-09.pdf',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
