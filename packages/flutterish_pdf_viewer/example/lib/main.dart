import 'package:flutter/material.dart';
import 'package:flutterish_pdf_viewer/flutterish_pdf_viewer.dart';
import 'examples/asset_pdf_example.dart';
import 'examples/custom_controls_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterish PDF Viewer - Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutterish PDF Viewer - Demo'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(
                    Icons.picture_as_pdf,
                    size: 64,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Flutterish PDF Viewer',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A Pure Flutter/Dart PDF Viewer',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No native dependencies required • Web compatible • Easy to use',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Features Section
          Text(
            'Features',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            context,
            Icons.language,
            'Load from URL',
            'Load PDFs directly from web URLs',
          ),
          _buildFeatureCard(
            context,
            Icons.insert_drive_file,
            'Load from Bytes',
            'Load PDFs from local files or byte arrays',
          ),
          _buildFeatureCard(
            context,
            Icons.download,
            'Download PDFs',
            'Save PDFs to device storage',
          ),
          _buildFeatureCard(
            context,
            Icons.navigation,
            'Page Navigation',
            'Built-in or custom page controls',
          ),
          _buildFeatureCard(
            context,
            Icons.palette,
            'Customizable',
            'Customize viewer appearance and behavior',
          ),
          const SizedBox(height: 24),
          // Demo Examples Section
          Text(
            'Try the Demos',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          _buildDemoCard(
            context,
            'Basic PDF Viewer',
            'Load PDFs from URLs with built-in controls',
            Icons.cloud_download,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PdfViewerDemo(),
              ),
            ),
          ),
          _buildDemoCard(
            context,
            'Custom Controls',
            'Build your own custom navigation controls',
            Icons.tune,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomControlsExample(),
              ),
            ),
          ),
          _buildDemoCard(
            context,
            'Asset PDF Example',
            'Load PDFs from local assets',
            Icons.folder,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AssetPdfExample(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Links
          Center(
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.code),
                  label: const Text('View on GitHub'),
                  onPressed: () {
                    // In a real app, would open URL
                  },
                ),
                TextButton.icon(
                  icon: const Icon(Icons.description),
                  label: const Text('Documentation'),
                  onPressed: () {
                    // In a real app, would open URL
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }

  Widget _buildDemoCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 48, color: Theme.of(context).primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(description),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class PdfViewerDemo extends StatefulWidget {
  const PdfViewerDemo({Key? key}) : super(key: key);

  @override
  State<PdfViewerDemo> createState() => _PdfViewerDemoState();
}

class _PdfViewerDemoState extends State<PdfViewerDemo> {
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
    final path = await _controller.downloadPdf('downloaded.pdf');
    if (path != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF downloaded to: $path')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic PDF Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _controller.document != null ? _downloadPdf : null,
            tooltip: 'Download PDF',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(
                      labelText: 'PDF URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _loadPdf,
                  child: const Text('Load'),
                ),
              ],
            ),
          ),
          Expanded(
            child: PdfViewer(
              controller: _controller,
              showControls: true,
            ),
          ),
        ],
      ),
    );
  }
}
