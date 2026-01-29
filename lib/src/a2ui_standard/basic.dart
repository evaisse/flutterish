import 'package:flutter/material.dart';
import '../a2ui/registry.dart';
import '../a2ui/protocol.dart'; // For UserAction

Widget a2TextBuilder(Map<String, dynamic> properties, A2UIContext context) {
  final text = context.resolveString(properties['text']) ?? '';
  // usageHint handling could be added here (h1, h2, etc.)
  final usageHint = context.resolveString(properties['usageHint']);

  TextStyle? style;
  if (usageHint == 'h1') style = Theme.of(context.context).textTheme.displayLarge;
  if (usageHint == 'h2') style = Theme.of(context.context).textTheme.displayMedium;
  if (usageHint == 'h3') style = Theme.of(context.context).textTheme.displaySmall;

  return Text(text, style: style);
}

Widget a2ImageBuilder(Map<String, dynamic> properties, A2UIContext context) {
  final url = context.resolveString(properties['url']);
  if (url == null) return const SizedBox.shrink();

  return Image.network(url);
}

Widget a2ButtonBuilder(Map<String, dynamic> properties, A2UIContext context) {
  // Child is a single ID usually
  final childId = properties['child'] as String?;
  final childWidget = childId != null
      ? context.buildChild(childId)
      : const SizedBox.shrink();

  return ElevatedButton(
    onPressed: () {
      final actionMap = properties['action'] as Map<String, dynamic>?;
      if (actionMap != null) {
        final name = actionMap['name'] as String;
        final contextList = actionMap['context'] as List? ?? [];

        // Resolve context
        final resolvedContext = <String, dynamic>{};
        for (var item in contextList) {
           if (item is Map<String, dynamic>) {
              final key = item['key'] as String;
              final valueProp = item['value']; // This is a BoundValue definition
              // We need to resolve this value definition against the surface data model

              // We can use the A2UIContext.resolve method if we treat it as a property map?
              // 'value' in the context list: { "path": "..." } or { "literalString": "..." }
              if (valueProp is Map<String, dynamic>) {
                 resolvedContext[key] = context.resolve(valueProp);
              }
           }
        }

        final userAction = UserAction(
          name: name,
          surfaceId: context.surfaceState.surfaceId,
          sourceComponentId: 'unknown', // Need to pass ID down if we want this accurate, spec says required.
          // Current architecture passes properties, not ID to builder.
          // Might need to update builder signature or pass ID in context?
          // For now, hardcode or ignore.
          timestamp: DateTime.now().toIso8601String(),
          context: resolvedContext,
        );

        context.onUserAction(userAction);
      }
    },
    child: childWidget,
  );
}
