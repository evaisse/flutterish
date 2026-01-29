import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/schema/schema_models.dart';
import '../../core/state/ui_state.dart';
import '../../core/state/resource_state.dart';
import '../../core/engine/sdui_builder.dart';

class AdminScaffold extends ConsumerWidget {
  final AdminConfig config;

  const AdminScaffold({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedResourceIndexProvider);
    final resources = config.resources;
    final currentResource = resources.isNotEmpty && selectedIndex < resources.length
        ? resources[selectedIndex]
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(config.title)),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              ref.read(selectedResourceIndexProvider.notifier).set(index);
            },
            labelType: NavigationRailLabelType.all,
            destinations: resources.map((r) => NavigationRailDestination(
              icon: const Icon(Icons.folder_open),
              selectedIcon: const Icon(Icons.folder),
              label: Text(r.name)
            )).toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: currentResource != null
                ? _ResourceView(resource: currentResource)
                : const Center(child: Text('No resources defined')),
          ),
        ],
      ),
    );
  }
}

class _ResourceView extends StatelessWidget {
  final ResourceConfig resource;

  const _ResourceView({required this.resource});

  @override
  Widget build(BuildContext context) {
    final listConfig = resource.list;
    if (listConfig == null) {
      return const Center(child: Text('No list view defined for this resource'));
    }

    return ProviderScope(
      overrides: [
        currentResourceProvider.overrideWithValue(resource.name),
      ],
      child: SduiBuilder(config: listConfig),
    );
  }
}
