import 'package:flutter_test/flutter_test.dart';
import 'package:flutterish_pdf_viewer/flutterish_pdf_viewer.dart';
import 'dart:typed_data';

void main() {
  group('PdfController', () {
    test('should initialize with no document', () {
      final controller = PdfController();
      expect(controller.document, isNull);
      expect(controller.isLoading, isFalse);
      expect(controller.error, isNull);
      expect(controller.currentPage, equals(0));
      controller.dispose();
    });

    test('should load PDF from bytes', () async {
      final controller = PdfController();
      final bytes = Uint8List.fromList([1, 2, 3, 4]);

      await controller.loadFromBytes(bytes);

      expect(controller.document, isNotNull);
      expect(controller.isLoading, isFalse);
      controller.dispose();
    });

    test('should navigate to next page', () {
      final controller = PdfController();
      controller.nextPage(); // Should do nothing when no document
      expect(controller.currentPage, equals(0));
      controller.dispose();
    });

    test('should navigate to previous page', () {
      final controller = PdfController();
      controller.previousPage();
      expect(controller.currentPage, equals(0));
      controller.dispose();
    });
  });

  group('PdfDocument', () {
    test('should create from bytes', () async {
      final bytes = Uint8List.fromList([1, 2, 3, 4]);
      final document = await PdfDocument.fromBytes(bytes);

      expect(document.bytes, equals(bytes));
      expect(document.pageCount, greaterThanOrEqualTo(1));
    });
  });
}
