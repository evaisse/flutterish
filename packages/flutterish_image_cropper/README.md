# Flutterish Image Cropper

A pure Dart/Flutter image cropper library with **no native dependencies**. This package provides an interactive image cropping widget that works entirely in Dart and Flutter, making it platform-independent and easy to use.

## 🌐 Live Demo

**[Try the interactive demo →](https://evaisse.github.io/flutterish_image_cropper/)**

Experience all features of the library in action with our live web demo!

## Features

✨ **Pure Dart/Flutter** - No platform-specific code or native dependencies  
🎯 **Interactive Cropping** - Drag corners to resize the crop area  
📐 **Aspect Ratio Support** - Constrain crops to specific aspect ratios (1:1, 4:3, 16:9, etc.)  
🔄 **Rotation** - Rotate images by 90-degree increments  
👆 **Gesture Support** - Pinch to zoom and pan the image  
🎨 **Customizable UI** - Configure colors, grid visibility, and boundary styles  
⚡ **Efficient** - Uses the `image` package for fast image processing in Dart  

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutterish_image_cropper: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:flutterish_image_cropper/flutterish_image_cropper.dart';
import 'dart:ui' as ui;

class MyCropperPage extends StatefulWidget {
  @override
  _MyCropperPageState createState() => _MyCropperPageState();
}

class _MyCropperPageState extends State<MyCropperPage> {
  final CropController _controller = CropController();

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    // Load your image as ui.Image
    // You can use image_picker, assets, or network images
    ui.Image image = ...; // Load your image here
    _controller.setImage(image);
  }

  Future<void> _cropImage() async {
    final result = await _controller.crop();
    if (result != null) {
      // Use the cropped image
      print('Cropped image size: ${result.width}x${result.height}');
      // result.imageBytes contains the PNG bytes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Cropper'),
        actions: [
          IconButton(
            icon: Icon(Icons.crop),
            onPressed: _cropImage,
          ),
        ],
      ),
      body: ImageCropper(
        controller: _controller,
        aspectRatio: 1.0, // Square crop
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### Advanced Features

#### Aspect Ratio Constraints

```dart
// Free crop (no constraint)
ImageCropper(controller: controller, aspectRatio: null)

// Square crop
ImageCropper(controller: controller, aspectRatio: 1.0)

// 16:9 crop
ImageCropper(controller: controller, aspectRatio: 16/9)

// 4:3 crop
ImageCropper(controller: controller, aspectRatio: 4/3)
```

#### Rotation

```dart
// Rotate 90 degrees clockwise
_controller.rotateRight();

// Rotate 90 degrees counter-clockwise
_controller.rotateLeft();
```

#### Customization

```dart
ImageCropper(
  controller: _controller,
  backgroundColor: Colors.black,
  overlayColor: Color(0x88000000),
  boundaryColor: Colors.white,
  boundaryWidth: 2.0,
  showGrid: true,
  aspectRatio: 16/9,
)
```

## API Reference

### CropController

The main controller for managing crop state and operations.

**Methods:**
- `setImage(ui.Image image)` - Set the image to crop
- `setCropRect(Rect rect)` - Set the crop rectangle (normalized coordinates 0-1)
- `setRotation(double rotation)` - Set rotation in radians
- `setScale(double scale)` - Set zoom scale (0.5 - 5.0)
- `setOffset(Offset offset)` - Set pan offset
- `setAspectRatio(double? ratio)` - Set aspect ratio constraint
- `rotateRight()` - Rotate 90° clockwise
- `rotateLeft()` - Rotate 90° counter-clockwise
- `Future<CropResult?> crop()` - Perform the crop and return result

### ImageCropper Widget

The interactive cropping widget.

**Parameters:**
- `controller` (required) - The CropController
- `backgroundColor` - Background color (default: Colors.black)
- `overlayColor` - Overlay color for non-crop areas (default: Color(0x88000000))
- `boundaryColor` - Color of crop boundaries (default: Colors.white)
- `boundaryWidth` - Width of boundary lines (default: 2.0)
- `showGrid` - Show grid lines (default: true)
- `aspectRatio` - Aspect ratio constraint (default: null)

### CropResult

The result of a crop operation.

**Properties:**
- `imageBytes` - Uint8List containing PNG image data
- `width` - Width of cropped image in pixels
- `height` - Height of cropped image in pixels

## How It Works

This library uses pure Dart/Flutter technologies:

1. **UI Layer**: Flutter's CustomPaint and GestureDetector for the interactive cropping interface
2. **Image Processing**: The `image` package for decoding, transforming, and encoding images
3. **No Platform Channels**: Everything runs in Dart, making it truly cross-platform

The cropping process:
1. User interacts with the crop area using gestures
2. Crop rectangle coordinates are maintained in normalized space (0-1)
3. When crop() is called, the image is processed using the `image` package
4. Rotation and cropping are applied in Dart
5. Result is encoded as PNG bytes

## Example App

Check out the [example](example/) directory for a complete demonstration app showing all features including:
- Loading images
- Interactive cropping with gestures
- Aspect ratio switching
- Rotation controls
- Displaying cropped results

To run the example:

```bash
cd example
flutter run
```

## Platform Support

✅ Android  
✅ iOS  
✅ Web  
✅ macOS  
✅ Linux  
✅ Windows  

Works on all Flutter platforms since it uses no native code!

## Development

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run only golden tests
flutter test test/image_cropper_golden_test.dart
```

### Golden Tests

This project includes golden (snapshot) tests to ensure UI consistency. To update golden files after intentional UI changes:

```bash
flutter test --update-goldens
```

See [test/goldens/README.md](test/goldens/README.md) for more information about golden tests.

### Code Quality

Before submitting a PR, ensure your code passes all checks:

```bash
# Format code
dart format .

# Analyze code
flutter analyze

# Run tests
flutter test
```

The CI workflow will automatically run these checks on all pull requests.

## License

MIT License - see LICENSE file for details

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
