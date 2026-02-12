import 'package:flutter/widgets.dart';
import 'protocol.dart';
import 'state.dart';
import 'registry.dart';

class A2UISurfaceView extends StatelessWidget {
  final SurfaceState surfaceState;
  final ComponentRegistry registry;
  final Function(UserAction) onUserAction;

  const A2UISurfaceView({
    super.key,
    required this.surfaceState,
    required this.registry,
    required this.onUserAction,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: surfaceState,
      builder: (context, _) {
        if (!surfaceState.isReady || surfaceState.rootId == null) {
          return const SizedBox.shrink(); // Or loading indicator
        }
        return _buildComponent(surfaceState.rootId!, context);
      },
    );
  }

  Widget _buildComponent(String id, BuildContext context) {
    final componentDef = surfaceState.components[id];
    if (componentDef == null) {
      return Text('Component not found: $id');
    }

    final a2Context = A2UIContext(
      context: context,
      surfaceState: surfaceState,
      buildChild: (childId) => _buildComponent(childId, context),
      onUserAction: onUserAction,
    );

    return registry.build(
      componentDef.type,
      componentDef.properties,
      a2Context,
    );
  }
}
