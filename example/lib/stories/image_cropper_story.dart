import 'package:flutter/material.dart';
import 'package:flutterish/flutterish.dart';

class ImageCropperStory extends StatefulWidget {
  const ImageCropperStory({super.key});

  @override
  State<ImageCropperStory> createState() => _ImageCropperStoryState();
}

class _ImageCropperStoryState extends State<ImageCropperStory> {
  late CropController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CropController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Cropper Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('L\'Image Cropper nécessite une image pour fonctionner.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: const Text('Crop Image'),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () async {
                            final result = await _controller.crop();
                            if (!mounted) return;
                            
                            Navigator.of(context).pop();
                            
                            if (result != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Image recadrée : ${result.width}x${result.height}')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    body: ImageCropper(
                      controller: _controller,
                    ),
                  ),
                );
              },
              child: const Text('Ouvrir le Cropper'),
            ),
          ],
        ),
      ),
    );
  }
}
