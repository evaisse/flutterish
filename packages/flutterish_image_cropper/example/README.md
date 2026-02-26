# Flutterish Image Cropper Demo

This is the example/demo app for the `flutterish_image_cropper` package.

## 🌐 Live Demo

**[Try the live demo here](https://evaisse.github.io/flutterish_image_cropper/)**

## Features Demonstrated

This demo showcases all the features of the Flutterish Image Cropper library:

- ✅ **Image Loading**: Pick images from your device or use a sample image
- ✅ **Interactive Cropping**: Drag the corners to adjust the crop area
- ✅ **Aspect Ratio Controls**: Switch between different aspect ratios (Free, 1:1, 4:3, 16:9, etc.)
- ✅ **Rotation**: Rotate images left or right by 90 degrees
- ✅ **Grid Toggle**: Show/hide the grid overlay
- ✅ **Crop Preview**: See the final cropped result
- ✅ **Gesture Support**: Pinch to zoom and pan the image

## Running Locally

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher

### Installation

1. Clone the repository:
```bash
git clone https://github.com/evaisse/flutterish_image_cropper.git
cd flutterish_image_cropper/example
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:

**For Web:**
```bash
flutter run -d chrome
```

**For Mobile:**
```bash
flutter run
```

**For Desktop:**
```bash
flutter run -d macos    # macOS
flutter run -d windows  # Windows
flutter run -d linux    # Linux
```

## Building for Web

To build the web version for deployment:

```bash
flutter build web --release
```

The built files will be in `build/web/`.

## Code Structure

- `lib/main.dart` - Main application code with all demo features
- `web/` - Web-specific assets (icons, manifest, etc.)

## Usage in Your App

To use the image cropper in your own app, check out the [main README](../README.md) for installation instructions and API documentation.
