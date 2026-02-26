import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import 'crop_result.dart';

/// Controller for managing the image cropping state and operations.
class CropController extends ChangeNotifier {
  ui.Image? _image;
  Rect _cropRect = Rect.zero;
  double _rotation = 0.0;
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  double? _aspectRatio;

  /// The original image to be cropped.
  ui.Image? get image => _image;

  /// The current crop rectangle.
  Rect get cropRect => _cropRect;

  /// The current rotation angle in radians.
  double get rotation => _rotation;

  /// The current scale factor.
  double get scale => _scale;

  /// The current pan offset.
  Offset get offset => _offset;

  /// The aspect ratio constraint (width/height), or null for free cropping.
  double? get aspectRatio => _aspectRatio;

  /// Set the image to be cropped.
  void setImage(ui.Image image) {
    _image = image;
    _scale = 1.0;
    _offset = Offset.zero;
    _rotation = 0.0;
    notifyListeners();
  }

  /// Set the crop rectangle.
  void setCropRect(Rect rect) {
    _cropRect = rect;
    notifyListeners();
  }

  /// Set the rotation angle in radians.
  void setRotation(double rotation) {
    _rotation = rotation;
    notifyListeners();
  }

  /// Set the scale factor.
  void setScale(double scale) {
    _scale = scale.clamp(0.5, 5.0);
    notifyListeners();
  }

  /// Set the pan offset.
  void setOffset(Offset offset) {
    _offset = offset;
    notifyListeners();
  }

  /// Set the aspect ratio constraint.
  void setAspectRatio(double? aspectRatio) {
    _aspectRatio = aspectRatio;
    notifyListeners();
  }

  /// Rotate the image by 90 degrees clockwise.
  void rotateRight() {
    _rotation += 1.5708; // π/2 radians
    notifyListeners();
  }

  /// Rotate the image by 90 degrees counter-clockwise.
  void rotateLeft() {
    _rotation -= 1.5708; // π/2 radians
    notifyListeners();
  }

  /// Crop the image based on the current crop rectangle.
  Future<CropResult?> crop() async {
    if (_image == null) return null;

    try {
      // Convert ui.Image to bytes
      final byteData = await _image!.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return null;

      // Decode image using the image package
      final bytes = byteData.buffer.asUint8List();
      img.Image? decodedImage = img.decodeImage(bytes);
      if (decodedImage == null) return null;

      // Apply rotation if needed
      if (_rotation != 0) {
        final degrees = (_rotation * 180 / 3.14159).round();
        decodedImage = img.copyRotate(decodedImage, angle: degrees);
      }

      // Calculate crop rectangle in image coordinates
      final imageWidth = decodedImage.width;
      final imageHeight = decodedImage.height;

      // Ensure crop rect is within bounds
      final x = (_cropRect.left * imageWidth).toInt().clamp(0, imageWidth - 1);
      final y = (_cropRect.top * imageHeight).toInt().clamp(0, imageHeight - 1);
      final width =
          (_cropRect.width * imageWidth).toInt().clamp(1, imageWidth - x);
      final height =
          (_cropRect.height * imageHeight).toInt().clamp(1, imageHeight - y);

      // Crop the image
      final croppedImage = img.copyCrop(
        decodedImage,
        x: x,
        y: y,
        width: width,
        height: height,
      );

      // Encode back to PNG
      final croppedBytes = img.encodePng(croppedImage);

      return CropResult(
        imageBytes: Uint8List.fromList(croppedBytes),
        width: croppedImage.width,
        height: croppedImage.height,
      );
    } catch (e) {
      debugPrint('Error cropping image: $e');
      return null;
    }
  }

  @override
  void dispose() {
    _image?.dispose();
    super.dispose();
  }
}
