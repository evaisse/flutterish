import 'package:flutter/widgets.dart';
import 'protocol.dart';
import 'state.dart';
import 'data_binding.dart';

/// Context passed to component builders.
class A2UIContext {
  final BuildContext context;
  final SurfaceState surfaceState;
  final Widget Function(String childId) buildChild;
  final Function(UserAction action) onUserAction;

  A2UIContext({
    required this.context,
    required this.surfaceState,
    required this.buildChild,
    required this.onUserAction,
  });

  /// Resolves a BoundValue property.
  dynamic resolve(Map<String, dynamic> property) {
    // If property is not a map, return as is (literal)
    // Actually properties from JSON are Maps if they are objects.
    // BoundValue logic:
    final bound = BoundValue.fromJson(property);
    return bound.resolve(surfaceState.dataModel);
  }

  /// Helper to resolve string property specifically
  String? resolveString(dynamic property) {
    if (property is Map<String, dynamic>) {
       return resolve(property)?.toString();
    }
    return property?.toString();
  }
}

typedef A2ComponentBuilder = Widget Function(
  Map<String, dynamic> properties,
  A2UIContext context,
);

class ComponentRegistry {
  final Map<String, A2ComponentBuilder> _builders = {};

  void register(String type, A2ComponentBuilder builder) {
    _builders[type] = builder;
  }

  Widget build(String type, Map<String, dynamic> properties, A2UIContext context) {
    final builder = _builders[type];
    if (builder == null) {
      return Text('Unknown component: $type'); // Fallback
    }
    return builder(properties, context);
  }
}
