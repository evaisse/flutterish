import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'crop_controller.dart';

/// A widget that displays an interactive image cropper.
///
/// This widget allows users to select a crop area by dragging corners,
/// pan and zoom the image, and rotate it. All processing is done in pure Dart.
class ImageCropper extends StatefulWidget {
  /// The controller managing the crop state.
  final CropController controller;

  /// The background color behind the image.
  final Color backgroundColor;

  /// The color of the crop overlay (areas outside the crop rectangle).
  final Color overlayColor;

  /// The color of the crop boundary lines and corners.
  final Color boundaryColor;

  /// The width of the crop boundary lines.
  final double boundaryWidth;

  /// Whether to show the grid lines inside the crop area.
  final bool showGrid;

  /// The aspect ratio constraint (width/height), or null for free cropping.
  final double? aspectRatio;

  const ImageCropper({
    super.key,
    required this.controller,
    this.backgroundColor = Colors.black,
    this.overlayColor = const Color(0x88000000),
    this.boundaryColor = Colors.white,
    this.boundaryWidth = 2.0,
    this.showGrid = true,
    this.aspectRatio,
  });

  @override
  State<ImageCropper> createState() => _ImageCropperState();
}

class _ImageCropperState extends State<ImageCropper> {
  Offset _lastFocalPoint = Offset.zero;
  double _lastScale = 1.0;
  int? _activeCorner;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerUpdate);
    widget.controller.setAspectRatio(widget.aspectRatio);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCropRect();
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerUpdate);
    super.dispose();
  }

  void _onControllerUpdate() {
    setState(() {});
  }

  void _initializeCropRect() {
    if (widget.controller.image != null &&
        widget.controller.cropRect == Rect.zero) {
      // Initialize crop rect to 80% of the image, centered
      final aspectRatio = widget.aspectRatio ?? 1.0;
      const double width = 0.8;
      final height = aspectRatio <= 1.0 ? 0.8 : 0.8 / aspectRatio;
      const double left = (1.0 - width) / 2;
      final top = (1.0 - height) / 2;

      widget.controller.setCropRect(
        Rect.fromLTWH(left, top, width, height),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: widget.controller.image == null
          ? const Center(
              child: Text(
                'No image loaded',
                style: TextStyle(color: Colors.white),
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return GestureDetector(
                  onScaleStart: _handleScaleStart,
                  onScaleUpdate: _handleScaleUpdate,
                  child: CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: _CropPainter(
                      image: widget.controller.image!,
                      cropRect: widget.controller.cropRect,
                      rotation: widget.controller.rotation,
                      scale: widget.controller.scale,
                      offset: widget.controller.offset,
                      overlayColor: widget.overlayColor,
                      boundaryColor: widget.boundaryColor,
                      boundaryWidth: widget.boundaryWidth,
                      showGrid: widget.showGrid,
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _lastFocalPoint = details.focalPoint;
    _lastScale = widget.controller.scale;

    // Check if user is touching a corner
    _activeCorner = _getCornerAtPosition(details.focalPoint);
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (_activeCorner != null) {
      // Resize crop rect by dragging corner
      _resizeCropRect(details.focalPoint);
    } else if (details.scale != 1.0) {
      // Pinch to zoom
      final newScale = _lastScale * details.scale;
      widget.controller.setScale(newScale);
    } else {
      // Pan
      final delta = details.focalPoint - _lastFocalPoint;
      widget.controller.setOffset(widget.controller.offset + delta);
      _lastFocalPoint = details.focalPoint;
    }
  }

  int? _getCornerAtPosition(Offset position) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    final size = renderBox.size;
    final cropRect = widget.controller.cropRect;

    final corners = [
      Offset(cropRect.left * size.width, cropRect.top * size.height),
      Offset(cropRect.right * size.width, cropRect.top * size.height),
      Offset(cropRect.right * size.width, cropRect.bottom * size.height),
      Offset(cropRect.left * size.width, cropRect.bottom * size.height),
    ];

    const touchRadius = 40.0;
    for (int i = 0; i < corners.length; i++) {
      if ((corners[i] - position).distance < touchRadius) {
        return i;
      }
    }
    return null;
  }

  void _resizeCropRect(Offset position) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final cropRect = widget.controller.cropRect;
    final normalizedX = (position.dx / size.width).clamp(0.0, 1.0);
    final normalizedY = (position.dy / size.height).clamp(0.0, 1.0);

    Rect newRect;
    final aspectRatio = widget.aspectRatio;

    switch (_activeCorner) {
      case 0: // Top-left
        if (aspectRatio != null) {
          final newWidth = (cropRect.right - normalizedX).clamp(0.1, 1.0);
          final newHeight = newWidth / aspectRatio;
          final newTop =
              (cropRect.bottom - newHeight).clamp(0.0, cropRect.bottom - 0.1);
          newRect = Rect.fromLTRB(
            cropRect.right - newWidth,
            newTop,
            cropRect.right,
            cropRect.bottom,
          );
        } else {
          newRect = Rect.fromLTRB(
            normalizedX.clamp(0.0, cropRect.right - 0.1),
            normalizedY.clamp(0.0, cropRect.bottom - 0.1),
            cropRect.right,
            cropRect.bottom,
          );
        }
        break;
      case 1: // Top-right
        if (aspectRatio != null) {
          final newWidth = (normalizedX - cropRect.left).clamp(0.1, 1.0);
          final newHeight = newWidth / aspectRatio;
          final newTop =
              (cropRect.bottom - newHeight).clamp(0.0, cropRect.bottom - 0.1);
          newRect = Rect.fromLTRB(
            cropRect.left,
            newTop,
            cropRect.left + newWidth,
            cropRect.bottom,
          );
        } else {
          newRect = Rect.fromLTRB(
            cropRect.left,
            normalizedY.clamp(0.0, cropRect.bottom - 0.1),
            normalizedX.clamp(cropRect.left + 0.1, 1.0),
            cropRect.bottom,
          );
        }
        break;
      case 2: // Bottom-right
        if (aspectRatio != null) {
          final newWidth = (normalizedX - cropRect.left).clamp(0.1, 1.0);
          final newHeight = newWidth / aspectRatio;
          newRect = Rect.fromLTRB(
            cropRect.left,
            cropRect.top,
            cropRect.left + newWidth,
            cropRect.top + newHeight,
          );
        } else {
          newRect = Rect.fromLTRB(
            cropRect.left,
            cropRect.top,
            normalizedX.clamp(cropRect.left + 0.1, 1.0),
            normalizedY.clamp(cropRect.top + 0.1, 1.0),
          );
        }
        break;
      case 3: // Bottom-left
        if (aspectRatio != null) {
          final newWidth = (cropRect.right - normalizedX).clamp(0.1, 1.0);
          final newHeight = newWidth / aspectRatio;
          newRect = Rect.fromLTRB(
            cropRect.right - newWidth,
            cropRect.top,
            cropRect.right,
            cropRect.top + newHeight,
          );
        } else {
          newRect = Rect.fromLTRB(
            normalizedX.clamp(0.0, cropRect.right - 0.1),
            cropRect.top,
            cropRect.right,
            normalizedY.clamp(cropRect.top + 0.1, 1.0),
          );
        }
        break;
      default:
        return;
    }

    // Ensure rect stays within bounds
    final clampedRect = Rect.fromLTRB(
      newRect.left.clamp(0.0, 1.0),
      newRect.top.clamp(0.0, 1.0),
      newRect.right.clamp(0.0, 1.0),
      newRect.bottom.clamp(0.0, 1.0),
    );

    if (clampedRect.width > 0.1 && clampedRect.height > 0.1) {
      widget.controller.setCropRect(clampedRect);
    }
  }
}

class _CropPainter extends CustomPainter {
  final ui.Image image;
  final Rect cropRect;
  final double rotation;
  final double scale;
  final Offset offset;
  final Color overlayColor;
  final Color boundaryColor;
  final double boundaryWidth;
  final bool showGrid;

  _CropPainter({
    required this.image,
    required this.cropRect,
    required this.rotation,
    required this.scale,
    required this.offset,
    required this.overlayColor,
    required this.boundaryColor,
    required this.boundaryWidth,
    required this.showGrid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate image display size maintaining aspect ratio
    final imageAspect = image.width / image.height;
    final canvasAspect = size.width / size.height;

    double displayWidth, displayHeight;
    if (imageAspect > canvasAspect) {
      displayWidth = size.width;
      displayHeight = size.width / imageAspect;
    } else {
      displayHeight = size.height;
      displayWidth = size.height * imageAspect;
    }

    // Center the image
    final dx = (size.width - displayWidth) / 2 + offset.dx;
    final dy = (size.height - displayHeight) / 2 + offset.dy;

    // Save canvas state
    canvas.save();

    // Apply transformations
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(scale);
    canvas.rotate(rotation);
    canvas.translate(-size.width / 2, -size.height / 2);

    // Draw the image
    final srcRect =
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dstRect = Rect.fromLTWH(dx, dy, displayWidth, displayHeight);
    canvas.drawImageRect(image, srcRect, dstRect, Paint());

    canvas.restore();

    // Draw crop overlay
    final cropRectPixels = Rect.fromLTWH(
      cropRect.left * size.width,
      cropRect.top * size.height,
      cropRect.width * size.width,
      cropRect.height * size.height,
    );

    // Draw darkened overlay outside crop area
    final overlayPaint = Paint()..color = overlayColor;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, cropRectPixels.top), overlayPaint);
    canvas.drawRect(
      Rect.fromLTWH(
          0, cropRectPixels.top, cropRectPixels.left, cropRectPixels.height),
      overlayPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        cropRectPixels.right,
        cropRectPixels.top,
        size.width - cropRectPixels.right,
        cropRectPixels.height,
      ),
      overlayPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(0, cropRectPixels.bottom, size.width,
          size.height - cropRectPixels.bottom),
      overlayPaint,
    );

    // Draw crop boundary
    final boundaryPaint = Paint()
      ..color = boundaryColor
      ..strokeWidth = boundaryWidth
      ..style = PaintingStyle.stroke;
    canvas.drawRect(cropRectPixels, boundaryPaint);

    // Draw grid lines
    if (showGrid) {
      final gridPaint = Paint()
        ..color = boundaryColor.withValues(alpha: 0.5)
        ..strokeWidth = 1.0;

      // Vertical lines
      for (int i = 1; i < 3; i++) {
        final x = cropRectPixels.left + (cropRectPixels.width * i / 3);
        canvas.drawLine(
          Offset(x, cropRectPixels.top),
          Offset(x, cropRectPixels.bottom),
          gridPaint,
        );
      }

      // Horizontal lines
      for (int i = 1; i < 3; i++) {
        final y = cropRectPixels.top + (cropRectPixels.height * i / 3);
        canvas.drawLine(
          Offset(cropRectPixels.left, y),
          Offset(cropRectPixels.right, y),
          gridPaint,
        );
      }
    }

    // Draw corner handles
    final cornerPaint = Paint()
      ..color = boundaryColor
      ..style = PaintingStyle.fill;

    const double cornerSize = 20.0;
    final corners = [
      cropRectPixels.topLeft,
      cropRectPixels.topRight,
      cropRectPixels.bottomRight,
      cropRectPixels.bottomLeft,
    ];

    for (final corner in corners) {
      canvas.drawCircle(corner, cornerSize / 2, cornerPaint);
      canvas.drawCircle(
        corner,
        cornerSize / 2,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(_CropPainter oldDelegate) {
    return oldDelegate.image != image ||
        oldDelegate.cropRect != cropRect ||
        oldDelegate.rotation != rotation ||
        oldDelegate.scale != scale ||
        oldDelegate.offset != offset;
  }
}
