import 'package:flutter/widgets.dart';
import 'package:flutterish_a2ui/flutterish_a2ui.dart';

List<Widget> _resolveChildren(Map<String, dynamic> properties, A2UIContext context) {
  final childrenObj = properties['children'];
  if (childrenObj is Map<String, dynamic>) {
    final explicitList = childrenObj['explicitList'];
    if (explicitList is List) {
      return explicitList.map((id) => context.buildChild(id as String)).toList();
    }
  }
  return [];
}

MainAxisAlignment _resolveMainAxisAlignment(String? align) {
  switch (align) {
    case 'center': return MainAxisAlignment.center;
    case 'start': return MainAxisAlignment.start;
    case 'end': return MainAxisAlignment.end;
    case 'spaceBetween': return MainAxisAlignment.spaceBetween;
    case 'spaceAround': return MainAxisAlignment.spaceAround;
    case 'spaceEvenly': return MainAxisAlignment.spaceEvenly;
    default: return MainAxisAlignment.start;
  }
}

Widget a2ColumnBuilder(Map<String, dynamic> properties, A2UIContext context) {
  final children = _resolveChildren(properties, context);
  final alignment = context.resolveString(properties['alignment']);

  return Column(
    mainAxisAlignment: _resolveMainAxisAlignment(alignment),
    children: children,
  );
}

Widget a2RowBuilder(Map<String, dynamic> properties, A2UIContext context) {
  final children = _resolveChildren(properties, context);
  final alignment = context.resolveString(properties['alignment']);

  return Row(
    mainAxisAlignment: _resolveMainAxisAlignment(alignment),
    children: children,
  );
}
