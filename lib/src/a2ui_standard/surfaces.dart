import 'package:flutter/material.dart';
import '../a2ui/registry.dart';

Widget a2CardBuilder(Map<String, dynamic> properties, A2UIContext context) {
  final childId = properties['child'] as String?;
  final childWidget = childId != null
      ? context.buildChild(childId)
      : const SizedBox.shrink();

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: childWidget,
    ),
  );
}
