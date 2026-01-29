import 'package:flutter/widgets.dart';
import '../schema/schema_models.dart';
import 'component_registry.dart';

/// A widget that builds a UI subtree from a ComponentConfig.
class SduiBuilder extends StatelessWidget {
  final ComponentConfig config;

  const SduiBuilder({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    // Recursively build children
    final children = config.children.map((childConfig) {
      return SduiBuilder(config: childConfig);
    }).toList();

    // Delegate to registry to find the Flutter widget
    return ComponentRegistry().build(config, children);
  }
}
