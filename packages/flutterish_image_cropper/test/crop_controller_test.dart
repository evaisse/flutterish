import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterish_image_cropper/flutterish_image_cropper.dart';

void main() {
  group('CropController', () {
    late CropController controller;

    setUp(() {
      controller = CropController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('should initialize with default values', () {
      expect(controller.image, isNull);
      expect(controller.cropRect, equals(ui.Rect.zero));
      expect(controller.rotation, equals(0.0));
      expect(controller.scale, equals(1.0));
      expect(controller.offset, equals(ui.Offset.zero));
      expect(controller.aspectRatio, isNull);
    });

    test('should update crop rect', () {
      const rect = ui.Rect.fromLTWH(0.1, 0.1, 0.8, 0.8);
      controller.setCropRect(rect);
      expect(controller.cropRect, equals(rect));
    });

    test('should update rotation', () {
      controller.setRotation(1.5708); // 90 degrees in radians
      expect(controller.rotation, equals(1.5708));
    });

    test('should update scale within bounds', () {
      controller.setScale(2.0);
      expect(controller.scale, equals(2.0));

      // Test clamping
      controller.setScale(10.0);
      expect(controller.scale, equals(5.0));

      controller.setScale(0.1);
      expect(controller.scale, equals(0.5));
    });

    test('should update offset', () {
      const ui.Offset offset = ui.Offset(10, 20);
      controller.setOffset(offset);
      expect(controller.offset, equals(offset));
    });

    test('should update aspect ratio', () {
      controller.setAspectRatio(16 / 9);
      expect(controller.aspectRatio, equals(16 / 9));
    });

    test('should rotate right', () {
      final initialRotation = controller.rotation;
      controller.rotateRight();
      expect(controller.rotation, greaterThan(initialRotation));
    });

    test('should rotate left', () {
      final initialRotation = controller.rotation;
      controller.rotateLeft();
      expect(controller.rotation, lessThan(initialRotation));
    });
  });

  group('CropResult', () {
    test('should create with required parameters', () {
      final bytes = Uint8List(100);
      final result = CropResult(
        imageBytes: bytes,
        width: 200,
        height: 150,
      );

      expect(result.imageBytes, equals(bytes));
      expect(result.width, equals(200));
      expect(result.height, equals(150));
    });
  });
}
