import 'package:flutter/widgets.dart';
import '../schema/schema_models.dart';

/// Function signature for building a component from config and children widgets.
typedef ComponentBuilder = Widget Function(ComponentConfig config, List<Widget> children);

/// Singleton registry for mapping JSON component types to Flutter widgets.
class ComponentRegistry {
  static final ComponentRegistry _instance = ComponentRegistry._internal();
  factory ComponentRegistry() => _instance;
  ComponentRegistry._internal();

  final Map<String, ComponentBuilder> _builders = {};

  /// Register a component builder for a specific type.
  void register(String type, ComponentBuilder builder) {
    _builders[type] = builder;
  }

  /// Build a widget instance from config and children.
  Widget build(ComponentConfig config, List<Widget> children) {
    final builder = _builders[config.type];
    if (builder == null) {
      return Container(
        padding: const EdgeInsets.all(8),
        color: const Color(0xFFFFEBEE),
        child: Text(
          'Unknown component: ${config.type}',
          style: const TextStyle(color: Color(0xFFB71C1C)),
        ),
      );
    }
    return builder(config, children);
  }
}
