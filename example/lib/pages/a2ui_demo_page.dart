import 'dart:async';
import 'package:flutter/material.dart' hide StepState, StepperType; // Hide if conflict, though usually safe
import 'package:flutterish/flutterish.dart';

class A2UIDemoPage extends StatefulWidget {
  const A2UIDemoPage({super.key});

  @override
  State<A2UIDemoPage> createState() => _A2UIDemoPageState();
}

class _A2UIDemoPageState extends State<A2UIDemoPage> {
  late A2UIState _state;
  late A2UIParser _parser;
  late ComponentRegistry _registry;

  @override
  void initState() {
    super.initState();
    _state = A2UIState();
    _parser = A2UIParser(_state);
    _registry = createStandardCatalog();

    // Simulate streaming
    _simulateStream();
  }

  Future<void> _simulateStream() async {
    final messages = [
      '{"surfaceUpdate": {"surfaceId": "main", "components": [{"id": "root", "component": {"Column": {"children": {"explicitList": ["profile_card"]}}}}]}}',
      '{"surfaceUpdate": {"surfaceId": "main", "components": [{"id": "profile_card", "component": {"Card": {"child": "card_content"}}}]}}',
      '{"surfaceUpdate": {"surfaceId": "main", "components": [{"id": "card_content", "component": {"Column": {"children": {"explicitList": ["header_row", "bio_text"]}}}}]}}',
      '{"surfaceUpdate": {"surfaceId": "main", "components": [{"id": "header_row", "component": {"Row": {"alignment": "center", "children": {"explicitList": ["avatar", "name_column"]}}}}]} }',
      '{"surfaceUpdate": {"surfaceId": "main", "components": [{"id": "avatar", "component": {"Image": {"url": {"literalString": "https://avatar.iran.liara.run/public/33"}}}}]}}', // Using a real placeholder image
      '{"surfaceUpdate": {"surfaceId": "main", "components": [{"id": "name_column", "component": {"Column": {"alignment": "start", "children": {"explicitList": ["name_text", "handle_text"]}}}}]}}',
      '{"surfaceUpdate": {"surfaceId": "main", "components": [{"id": "name_text", "component": {"Text": {"usageHint": "h3", "text": {"literalString": "A2A Fan"}}}}]}}',
      '{"surfaceUpdate": {"surfaceId": "main", "components": [{"id": "handle_text", "component": {"Text": {"text": {"literalString": "@a2a_fan"}}}}]}}',
      '{"surfaceUpdate": {"surfaceId": "main", "components": [{"id": "bio_text", "component": {"Text": {"text": {"literalString": "Building beautiful apps from a single codebase."}}}}]}}',
      '{"dataModelUpdate": {"surfaceId": "main", "contents": []}}',
      '{"beginRendering": {"surfaceId": "main", "root": "root"}}'
    ];

    for (final line in messages) {
      await Future.delayed(const Duration(milliseconds: 100)); // Simulate network delay
      _parser.parseLine(line);
    }
  }

  void _handleUserAction(UserAction action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User Action: ${action.name}')),
    );
    // ignore: avoid_print
    print('UserAction: ${action.toJson()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A2UI Demo')),
      body: Center(
        child: A2UISurfaceView(
          surfaceState: _state.getSurface('main'),
          registry: _registry,
          onUserAction: _handleUserAction,
        ),
      ),
    );
  }
}
