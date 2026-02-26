import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'pdf_document.dart';

/// Controller for managing PDF documents
class PdfController extends ChangeNotifier {
  PdfDocument? _document;
  bool _isLoading = false;
  String? _error;
  int _currentPage = 0;

  /// Get the current PDF document
  PdfDocument? get document => _document;

  /// Check if a document is currently loading
  bool get isLoading => _isLoading;

  /// Get any error message
  String? get error => _error;

  /// Get the current page number (0-indexed)
  int get currentPage => _currentPage;

  /// Load a PDF from a URL
  Future<void> loadFromUrl(String url) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _document = await PdfDocument.fromBytes(response.bodyBytes);
      } else {
        _error = 'Failed to load PDF: HTTP ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error loading PDF: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load a PDF from bytes
  Future<void> loadFromBytes(Uint8List bytes) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _document = await PdfDocument.fromBytes(bytes);
    } catch (e) {
      _error = 'Error loading PDF: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Download the current PDF to device storage
  Future<String?> downloadPdf(String filename) async {
    if (_document == null) {
      throw StateError('No PDF document loaded');
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$filename');
      await file.writeAsBytes(_document!.bytes);
      return file.path;
    } catch (e) {
      _error = 'Error downloading PDF: $e';
      notifyListeners();
      return null;
    }
  }

  /// Go to a specific page
  void goToPage(int page) {
    if (_document != null && page >= 0 && page < _document!.pageCount) {
      _currentPage = page;
      notifyListeners();
    }
  }

  /// Go to the next page
  void nextPage() {
    if (_document != null && _currentPage < _document!.pageCount - 1) {
      _currentPage++;
      notifyListeners();
    }
  }

  /// Go to the previous page
  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _document = null;
    super.dispose();
  }
}
