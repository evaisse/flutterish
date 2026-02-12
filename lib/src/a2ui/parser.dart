import 'dart:convert';
import 'protocol.dart';
import 'state.dart';

class A2UIParser {
  final A2UIState state;

  A2UIParser(this.state);

  void parseLine(String line) {
    if (line.trim().isEmpty) return;

    try {
      final json = jsonDecode(line) as Map<String, dynamic>;

      if (json.containsKey('surfaceUpdate')) {
        state.processMessage(SurfaceUpdate.fromJson(json['surfaceUpdate']));
      } else if (json.containsKey('dataModelUpdate')) {
        state.processMessage(DataModelUpdate.fromJson(json['dataModelUpdate']));
      } else if (json.containsKey('beginRendering')) {
        state.processMessage(BeginRendering.fromJson(json['beginRendering']));
      }
      // Handle deleteSurface if needed

    } catch (e) {
      // ignore: avoid_print
      print('Error parsing A2UI message: $e\nLine: $line');
    }
  }
}
