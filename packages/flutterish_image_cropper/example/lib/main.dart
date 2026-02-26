import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutterish_image_cropper/flutterish_image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterish Image Cropper Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const CropperDemo(),
    );
  }
}

class CropperDemo extends StatefulWidget {
  const CropperDemo({super.key});

  @override
  State<CropperDemo> createState() => _CropperDemoState();
}

class _CropperDemoState extends State<CropperDemo> {
  final CropController _controller = CropController();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _croppedImageBytes;
  double? _aspectRatio;
  bool _showGrid = true;
  bool _hasLoadedImage = false;

  @override
  void initState() {
    super.initState();
    _loadSampleImage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadSampleImage() async {
    // Create a sample gradient image for demonstration
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    // Draw a colorful gradient sample image
    const size = 800.0;
    final gradient = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(size, size),
      [
        Colors.blue,
        Colors.purple,
        Colors.pink,
        Colors.orange,
      ],
    );

    paint.shader = gradient;
    canvas.drawRect(const Rect.fromLTWH(0, 0, size, size), paint);

    // Add some text
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Sample Image\nfor Cropping',
        style: TextStyle(
          color: Colors.white,
          fontSize: 60,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size - textPainter.width) / 2, (size - textPainter.height) / 2),
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());

    _controller.setImage(image);
    setState(() {
      _hasLoadedImage = true;
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2048,
        maxHeight: 2048,
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        final codec = await ui.instantiateImageCodec(bytes);
        final frame = await codec.getNextFrame();
        _controller.setImage(frame.image);
        setState(() {
          _hasLoadedImage = true;
          _croppedImageBytes = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  Future<void> _cropImage() async {
    final result = await _controller.crop();
    if (result != null) {
      setState(() {
        _croppedImageBytes = result.imageBytes;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image cropped: ${result.width}x${result.height}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _setAspectRatio(double? ratio) {
    setState(() {
      _aspectRatio = ratio;
    });
    _controller.setAspectRatio(ratio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutterish Image Cropper Demo'),
        actions: [
          if (_hasLoadedImage) ...[
            IconButton(
              icon: const Icon(Icons.rotate_left),
              onPressed: _controller.rotateLeft,
              tooltip: 'Rotate Left',
            ),
            IconButton(
              icon: const Icon(Icons.rotate_right),
              onPressed: _controller.rotateRight,
              tooltip: 'Rotate Right',
            ),
            IconButton(
              icon: Icon(_showGrid ? Icons.grid_on : Icons.grid_off),
              onPressed: () {
                setState(() {
                  _showGrid = !_showGrid;
                });
              },
              tooltip: 'Toggle Grid',
            ),
            PopupMenuButton<double?>(
              icon: const Icon(Icons.aspect_ratio),
              tooltip: 'Aspect Ratio',
              onSelected: _setAspectRatio,
              itemBuilder: (context) => [
                const PopupMenuItem(value: null, child: Text('Free')),
                const PopupMenuItem(value: 1.0, child: Text('Square (1:1)')),
                const PopupMenuItem(value: 4 / 3, child: Text('4:3')),
                const PopupMenuItem(value: 16 / 9, child: Text('16:9')),
                const PopupMenuItem(
                    value: 3 / 4, child: Text('3:4 (Portrait)')),
                const PopupMenuItem(value: 9 / 16, child: Text('9:16 (Story)')),
                const PopupMenuItem(value: 2 / 1, child: Text('2:1 (Wide)')),
              ],
            ),
          ],
        ],
      ),
      body: _hasLoadedImage
          ? Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ImageCropper(
                    controller: _controller,
                    aspectRatio: _aspectRatio,
                    backgroundColor: Colors.black87,
                    overlayColor: const Color(0xAA000000),
                    boundaryColor: Colors.white,
                    showGrid: _showGrid,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.photo_library),
                            label: const Text('Pick Image'),
                          ),
                          ElevatedButton.icon(
                            onPressed: _loadSampleImage,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Load Sample'),
                          ),
                          ElevatedButton.icon(
                            onPressed: _cropImage,
                            icon: const Icon(Icons.crop),
                            label: const Text('Crop'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (_croppedImageBytes != null) ...[
                        const Text(
                          'Cropped Result:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              _croppedImageBytes!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.crop_original,
                    size: 100,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Welcome to Flutterish Image Cropper',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'A pure Dart/Flutter image cropper with no native dependencies.\n'
                      'Features interactive cropping, rotation, and aspect ratio constraints.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Pick an Image'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: _loadSampleImage,
                    icon: const Icon(Icons.palette),
                    label: const Text('Or try with a sample image'),
                  ),
                ],
              ),
            ),
    );
  }
}
