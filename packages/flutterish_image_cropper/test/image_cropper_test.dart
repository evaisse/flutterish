import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterish_image_cropper/flutterish_image_cropper.dart';

void main() {
  group('ImageCropper Widget', () {
    testWidgets('should display "No image loaded" when no image is set',
        (WidgetTester tester) async {
      final controller = CropController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ImageCropper(controller: controller),
          ),
        ),
      );

      expect(find.text('No image loaded'), findsOneWidget);

      controller.dispose();
    });

    testWidgets('should accept custom colors', (WidgetTester tester) async {
      final controller = CropController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ImageCropper(
              controller: controller,
              backgroundColor: Colors.red,
              overlayColor: Colors.blue,
              boundaryColor: Colors.green,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.color, equals(Colors.red));

      controller.dispose();
    });
  });
}
