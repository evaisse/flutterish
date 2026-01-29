import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterish/src/core/engine/component_registry.dart';
import 'package:flutterish/src/core/schema/schema_models.dart';

void main() {
  group('SDUI Engine Tests', () {
    testWidgets('ComponentRegistry builds registered component', (tester) async {
      final registry = ComponentRegistry();
      // Clear registry first if it's singleton? Ideally we should make it mockable or resetable.
      // Since it's a singleton, we just overwrite 'TestBox' if it exists.
      registry.register('TestBox', (config, children) => Container(key: const Key('box')));

      final config = const ComponentConfig(type: 'TestBox');

      await tester.pumpWidget(registry.build(config, []));

      expect(find.byKey(const Key('box')), findsOneWidget);
    });

    testWidgets('ComponentRegistry handles unknown component', (tester) async {
      final registry = ComponentRegistry();
      final config = const ComponentConfig(type: 'UnknownComponentXYZ');

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: registry.build(config, [])
      ));

      expect(find.text('Unknown component: UnknownComponentXYZ'), findsOneWidget);
    });
  });
}
