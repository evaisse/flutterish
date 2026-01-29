import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/state/record_state.dart';
import '../../core/schema/schema_models.dart';

class TextFieldComponent extends ConsumerWidget {
  final String source;

  const TextFieldComponent({super.key, required this.source});

  static Widget builder(ComponentConfig config, List<Widget> children) {
    return TextFieldComponent(source: config.props['source'] ?? '');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(recordProvider);
    final value = record[source];
    return Text(value?.toString() ?? '');
  }
}
