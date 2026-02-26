# API Documentation

## Overview

Flutterish Image Cropper is a pure Dart/Flutter library for cropping images with no native dependencies. This makes it truly cross-platform and easy to integrate.

## Core Classes

### CropController

The main controller for managing crop operations and state.

#### Constructor

```dart
final controller = CropController();
```

#### Properties

- `image` (ui.Image?) - The currently loaded image
- `cropRect` (Rect) - The crop rectangle in normalized coordinates (0-1)
- `rotation` (double) - Current rotation angle in radians
- `scale` (double) - Current zoom scale factor (0.5-5.0)
- `offset` (Offset) - Pan offset from center
- `aspectRatio` (double?) - Aspect ratio constraint (width/height) or null for free crop

#### Methods

**setImage(ui.Image image)**
```dart
controller.setImage(image);
```
Sets the image to be cropped. Resets scale, offset, and rotation.

**setCropRect(Rect rect)**
```dart
controller.setCropRect(Rect.fromLTWH(0.1, 0.1, 0.8, 0.8));
```
Sets the crop rectangle in normalized coordinates (0-1 for both x and y).

**setRotation(double rotation)**
```dart
controller.setRotation(1.5708); // 90 degrees in radians
```
Sets the rotation angle in radians.

**setScale(double scale)**
```dart
controller.setScale(2.0); // 2x zoom
```
Sets the zoom scale. Automatically clamped between 0.5 and 5.0.

**setOffset(Offset offset)**
```dart
controller.setOffset(Offset(10, 20));
```
Sets the pan offset in pixels.

**setAspectRatio(double? aspectRatio)**
```dart
controller.setAspectRatio(16/9); // 16:9 aspect ratio
controller.setAspectRatio(null); // Free crop
```
Sets the aspect ratio constraint for the crop rectangle.

**rotateRight()**
```dart
controller.rotateRight();
```
Rotates the image 90 degrees clockwise.

**rotateLeft()**
```dart
controller.rotateLeft();
```
Rotates the image 90 degrees counter-clockwise.

**Future<CropResult?> crop()**
```dart
final result = await controller.crop();
if (result != null) {
  print('Cropped: ${result.width}x${result.height}');
  // Use result.imageBytes
}
```
Performs the crop operation and returns the result. Returns null if no image is loaded or crop fails.

**dispose()**
```dart
controller.dispose();
```
Disposes the controller and releases resources. Call this in your widget's dispose method.

---

### ImageCropper

The interactive widget for displaying and manipulating the crop area.

#### Constructor

```dart
ImageCropper(
  controller: controller,
  aspectRatio: 16/9,
  backgroundColor: Colors.black,
  overlayColor: Color(0x88000000),
  boundaryColor: Colors.white,
  boundaryWidth: 2.0,
  showGrid: true,
)
```

#### Parameters

- **controller** (CropController, required) - The controller managing the crop state
- **backgroundColor** (Color, default: Colors.black) - Background color behind the image
- **overlayColor** (Color, default: Color(0x88000000)) - Color of the overlay outside crop area
- **boundaryColor** (Color, default: Colors.white) - Color of crop boundary lines and handles
- **boundaryWidth** (double, default: 2.0) - Width of the crop boundary lines
- **showGrid** (bool, default: true) - Whether to show grid lines inside crop area
- **aspectRatio** (double?, default: null) - Aspect ratio constraint

#### Gestures

- **Drag corner handles** - Resize the crop area
- **Pinch** - Zoom in/out
- **Pan (one finger)** - Move the image

---

### CropResult

The result of a crop operation.

#### Properties

- `imageBytes` (Uint8List) - The cropped image data as PNG bytes
- `width` (int) - Width of the cropped image in pixels
- `height` (int) - Height of the cropped image in pixels

#### Usage

```dart
final result = await controller.crop();
if (result != null) {
  // Display the cropped image
  Image.memory(result.imageBytes);
  
  // Save to file
  File('cropped.png').writeAsBytes(result.imageBytes);
  
  // Get dimensions
  print('Size: ${result.width}x${result.height}');
}
```

---

### ImageLoader

Utility class for loading images from various sources.

#### Static Methods

**Future<ui.Image> fromAsset(String assetPath)**
```dart
final image = await ImageLoader.fromAsset('assets/photo.jpg');
controller.setImage(image);
```
Loads an image from the asset bundle.

**Future<ui.Image> fromBytes(Uint8List bytes)**
```dart
final image = await ImageLoader.fromBytes(imageBytes);
controller.setImage(image);
```
Loads an image from memory bytes.

**Future<ui.Image> fromNetwork(String url)**
```dart
// Note: Not available on web platforms!
// For web compatibility, use the http package:
// import 'package:http/http.dart' as http;
// final response = await http.get(Uri.parse(url));
// final image = await ImageLoader.fromBytes(response.bodyBytes);

// For non-web platforms only:
final image = await ImageLoader.fromNetwork('https://example.com/image.jpg');
controller.setImage(image);
```
Loads an image from a network URL. **Note:** This method is not supported on web platforms. For cross-platform network image loading, use a package like `http` or `dio` to fetch the image bytes, then use `fromBytes()`.

**Future<ui.Image> fromFile(dynamic file)**
```dart
// Works with File objects from image_picker or file_picker
final image = await ImageLoader.fromFile(pickedFile);
controller.setImage(image);
```
Loads an image from a file.

---

## Common Patterns

### Loading an Image from Image Picker

```dart
import 'package:image_picker/image_picker.dart';
import 'package:flutterish_image_cropper/flutterish_image_cropper.dart';

Future<void> pickAndCrop() async {
  final picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  
  if (pickedFile != null) {
    final bytes = await pickedFile.readAsBytes();
    final image = await ImageLoader.fromBytes(bytes);
    controller.setImage(image);
  }
}
```

### Saving Cropped Image

```dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> saveCroppedImage() async {
  final result = await controller.crop();
  if (result != null) {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(result.imageBytes);
    print('Saved to: ${file.path}');
  }
}
```

### Custom Aspect Ratios

```dart
// Common aspect ratios
controller.setAspectRatio(1.0);       // Square (Instagram)
controller.setAspectRatio(4/3);       // Standard photo
controller.setAspectRatio(16/9);      // Widescreen
controller.setAspectRatio(9/16);      // Vertical video (TikTok, Stories)
controller.setAspectRatio(21/9);      // Ultra-wide
controller.setAspectRatio(null);      // Free crop
```

### Listening to Crop State Changes

```dart
controller.addListener(() {
  print('Crop rect: ${controller.cropRect}');
  print('Scale: ${controller.scale}');
  print('Rotation: ${controller.rotation}');
});
```

---

## Best Practices

1. **Always dispose controllers**: Call `controller.dispose()` in your widget's dispose method to prevent memory leaks.

2. **Handle null results**: The `crop()` method returns null if there's no image or if cropping fails. Always check for null.

3. **Use normalized coordinates**: The crop rectangle uses normalized coordinates (0-1), making it resolution-independent.

4. **Provide visual feedback**: Show loading indicators when loading images and performing crop operations.

5. **Test on multiple platforms**: While the library works everywhere, test gesture handling on both touch and mouse devices.

6. **Optimize large images**: For very large images, consider downscaling before cropping to improve performance.

---

## Performance Tips

- The cropping operation runs in the Dart VM, not on the GPU, so very large images (>4000x4000) may take a moment to process.
- For best performance, load images at a reasonable resolution for your use case.
- The interactive preview is lightweight and runs at 60fps on most devices.

---

## Troubleshooting

**Image not displaying**
- Make sure you've called `controller.setImage()` with a valid ui.Image
- Check that the image was loaded successfully

**Crop returns null**
- Verify an image is loaded before calling `crop()`
- Check console for error messages

**Gestures not working**
- Ensure the ImageCropper widget has sufficient size
- Check that no other gesture detectors are intercepting touches

**Image appears rotated**
- Some images have EXIF orientation data that needs to be handled separately
- Use the rotation controls to correct orientation