import 'dart:typed_data';

/// Result of a crop operation containing the cropped image data.
class CropResult {
  /// The cropped image data as bytes.
  final Uint8List imageBytes;

  /// The width of the cropped image in pixels.
  final int width;

  /// The height of the cropped image in pixels.
  final int height;

  const CropResult({
    required this.imageBytes,
    required this.width,
    required this.height,
  });
}
