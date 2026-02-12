import 'package:flutter_test/flutter_test.dart';
import 'package:flutterish/flutterish.dart';

void main() {
  group('A2UIParser', () {
    late A2UIState state;
    late A2UIParser parser;

    setUp(() {
      state = A2UIState();
      parser = A2UIParser(state);
    });

    test('parses surfaceUpdate', () {
      final jsonl = '''
{"surfaceUpdate": {"surfaceId": "main", "components": [{"id": "root", "component": {"Column": {}}}]}}
''';
      parser.parseLine(jsonl);

      final surface = state.getSurface('main');
      expect(surface.components.containsKey('root'), isTrue);
      expect(surface.components['root']?.type, 'Column');
    });

    test('parses dataModelUpdate', () {
      final jsonl = '''
{"dataModelUpdate": {"surfaceId": "main", "path": "/user", "contents": [{"key": "name", "valueString": "Alice"}]}}
''';
      parser.parseLine(jsonl);

      final surface = state.getSurface('main');
      expect(surface.dataModel['user'], isNotNull);
      expect(surface.dataModel['user']['name'], 'Alice');
    });

    test('parses beginRendering', () {
      final jsonl = '''
{"beginRendering": {"surfaceId": "main", "root": "root1"}}
''';
      parser.parseLine(jsonl);

      final surface = state.getSurface('main');
      expect(surface.isReady, isTrue);
      expect(surface.rootId, 'root1');
    });
  });
}
