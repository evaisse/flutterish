import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/state/resource_state.dart';
import '../../core/state/list_state.dart';

class ListViewComponent extends ConsumerWidget {
  final List<Widget> children;
  final String title;

  const ListViewComponent({super.key, required this.children, this.title = ''});

  static Widget builder(ComponentConfig config, List<Widget> children) {
    return ListViewComponent(
      title: config.props['title'] ?? '',
      children: children,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resource = ref.watch(currentResourceProvider);
    final listDataAsync = ref.watch(listDataProvider(resource));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
            ),
          Expanded(
            child: listDataAsync.when(
              data: (data) => ProviderScope(
                overrides: [
                  listContextResultProvider.overrideWithValue(data),
                ],
                child: children.isNotEmpty
                    ? children.first
                    : const Center(child: Text('No list component (e.g. Datagrid) defined')),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading data: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
