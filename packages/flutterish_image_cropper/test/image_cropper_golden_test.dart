import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterish_image_cropper/flutterish_image_cropper.dart';

void main() {
  const double tolerance = 0.02; // 2% pixel diff tolerance.
  late GoldenFileComparator baselineComparator;

  setUpAll(() {
    baselineComparator = goldenFileComparator;
    final File testFile = File('test/image_cropper_golden_test.dart');
    goldenFileComparator = _ToleranceGoldenFileComparator(
      testFile.absolute.uri,
      precisionTolerance: tolerance,
    );
  });

  tearDownAll(() {
    goldenFileComparator = baselineComparator;
  });

  group('ImageCropper Golden Tests', () {
    testWidgets('should match golden for no image state', (
      WidgetTester tester,
    ) async {
      final controller = CropController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: ImageCropper(controller: controller),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(ImageCropper),
        matchesGoldenFile('goldens/image_cropper_no_image.png'),
      );

      controller.dispose();
    });

    testWidgets('should match golden with custom colors', (
      WidgetTester tester,
    ) async {
      final controller = CropController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: ImageCropper(
                controller: controller,
                backgroundColor: Colors.blue.shade900,
                overlayColor: Colors.purple.withValues(alpha: 0.3),
                boundaryColor: Colors.yellow,
                boundaryWidth: 3.0,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(ImageCropper),
        matchesGoldenFile('goldens/image_cropper_custom_colors.png'),
      );

      controller.dispose();
    });

    testWidgets('should match golden with grid disabled', (
      WidgetTester tester,
    ) async {
      final controller = CropController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: ImageCropper(controller: controller, showGrid: false),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(ImageCropper),
        matchesGoldenFile('goldens/image_cropper_no_grid.png'),
      );

      controller.dispose();
    });

    testWidgets('should match golden with aspect ratio', (
      WidgetTester tester,
    ) async {
      final controller = CropController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: ImageCropper(controller: controller, aspectRatio: 16 / 9),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(ImageCropper),
        matchesGoldenFile('goldens/image_cropper_aspect_ratio.png'),
      );

      controller.dispose();
    });
  });
}

class _ToleranceGoldenFileComparator extends LocalFileComparator {
  _ToleranceGoldenFileComparator(
    super.testFile, {
    required this.precisionTolerance,
  }) : assert(
         0 <= precisionTolerance && precisionTolerance <= 1,
         'precisionTolerance must be between 0 and 1',
       );

  final double precisionTolerance;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final ComparisonResult result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    final bool passed =
        result.passed || result.diffPercent <= precisionTolerance;
    if (passed) {
      result.dispose();
      return true;
    }

    final String error = await generateFailureOutput(result, golden, basedir);
    result.dispose();
    throw FlutterError(
      '$error\nDiff ${(result.diffPercent * 100).toStringAsFixed(2)}% exceeds '
      'tolerance of ${(precisionTolerance * 100).toStringAsFixed(2)}%.',
    );
  }
}
