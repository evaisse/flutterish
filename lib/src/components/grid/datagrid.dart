import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/state/list_state.dart';
import '../../core/state/record_state.dart';
import '../../core/schema/schema_models.dart';

class Datagrid extends ConsumerWidget {
  final ComponentConfig config;
  final List<Widget> children;

  const Datagrid({super.key, required this.config, required this.children});

  static Widget builder(ComponentConfig config, List<Widget> children) {
    return Datagrid(config: config, children: children);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We expect listContextResultProvider to be available (provided by ListView)
    final listResult = ref.watch(listContextResultProvider);

    // Derive columns from children config
    // This assumes that the 'children' widgets correspond 1-to-1 with config.children
    final columns = config.children.map((childConfig) {
      final label = childConfig.props['label'] ?? childConfig.props['source'] ?? '';
      return DataColumn(label: Text(label.toString()));
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: columns,
          rows: listResult.data.map((record) {
            return DataRow(
              cells: children.map((colWidget) {
                return DataCell(
                  ProviderScope(
                    overrides: [
                      recordProvider.overrideWithValue(record),
                    ],
                    child: colWidget,
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
