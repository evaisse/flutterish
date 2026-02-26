import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Utility functions for loading images into the cropper.
class ImageLoader {
  /// Load an image from asset bundle.
  ///
  /// Example:
  /// ```dart
  /// final image = await ImageLoader.fromAsset('assets/my_image.png');
  /// controller.setImage(image);
  /// ```
  static Future<ui.Image> fromAsset(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    return fromBytes(bytes);
  }

  /// Load an image from memory bytes.
  ///
  /// Example:
  /// ```dart
  /// final image = await ImageLoader.fromBytes(imageBytes);
  /// controller.setImage(image);
  /// ```
  static Future<ui.Image> fromBytes(Uint8List bytes) async {
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  /// Load an image from a network URL.
  ///
  /// Note: This method is not available on web platforms. Use a package like
  /// http or dio for cross-platform network image loading, then use fromBytes.
  ///
  /// Example:
  /// ```dart
  /// // For web compatibility, use:
  /// // import 'package:http/http.dart' as http;
  /// // final response = await http.get(Uri.parse(url));
  /// // final image = await ImageLoader.fromBytes(response.bodyBytes);
  ///
  /// // For non-web platforms only:
  /// final image = await ImageLoader.fromNetwork('https://example.com/image.jpg');
  /// controller.setImage(image);
  /// ```
  static Future<ui.Image> fromNetwork(String url) async {
    if (kIsWeb) {
      throw UnsupportedError('ImageLoader.fromNetwork is not supported on web. '
          'Use a package like http or dio to fetch the image bytes, '
          'then use ImageLoader.fromBytes(bytes).');
    }

    // This code path is only for non-web platforms
    // We can't use dart:io on web, so we use dynamic imports
    throw UnimplementedError(
        'Network loading requires dart:io which is not available. '
        'Please use ImageLoader.fromBytes with bytes from http package.');
  }

  /// Load an image from a file.
  ///
  /// The file parameter should be from image_picker (XFile) or similar packages.
  /// On web, XFile.readAsBytes() works without dart:io.
  ///
  /// Example:
  /// ```dart
  /// // Works on all platforms including web:
  /// final XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
  /// final bytes = await file.readAsBytes();
  /// final image = await ImageLoader.fromBytes(bytes);
  ///
  /// // Or use the convenience method:
  /// final image = await ImageLoader.fromFile(file);
  /// controller.setImage(image);
  /// ```
  static Future<ui.Image> fromFile(dynamic file) async {
    // For use with file_picker or image_picker packages
    // XFile and similar classes provide readAsBytes() that works on all platforms
    final Uint8List bytes = await file.readAsBytes();
    return fromBytes(bytes);
  }
}
