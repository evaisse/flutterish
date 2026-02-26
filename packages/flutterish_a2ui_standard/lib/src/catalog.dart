import 'package:flutterish_a2ui/flutterish_a2ui.dart';

import 'layout.dart';
import 'basic.dart';
import 'surfaces.dart';

ComponentRegistry createStandardCatalog() {
  final registry = ComponentRegistry();

  registry.register('Column', a2ColumnBuilder);
  registry.register('Row', a2RowBuilder);
  registry.register('Text', a2TextBuilder);
  registry.register('Image', a2ImageBuilder);
  registry.register('Button', a2ButtonBuilder);
  registry.register('Card', a2CardBuilder);

  return registry;
}
