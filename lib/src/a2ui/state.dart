import 'package:flutter/foundation.dart';
import 'protocol.dart';
import 'data_binding.dart';

/// Manages the state for a single surface.
class SurfaceState extends ChangeNotifier {
  final String surfaceId;

  /// Component buffer: `Map<String, ComponentDefinition>`
  final Map<String, ComponentDefinition> components = {};

  /// Data Model: `Map<String, dynamic>`
  final Map<String, dynamic> dataModel = {};

  /// The ID of the root component to render.
  String? rootId;

  /// Whether the surface is ready to render.
  bool isReady = false;

  SurfaceState(this.surfaceId);

  void updateComponents(List<ComponentDefinition> newComponents) {
    for (var comp in newComponents) {
      components[comp.id] = comp;
    }
    notifyListeners();
  }

  void updateDataModel(String? path, List<DataEntry> contents) {
    // Convert List<DataEntry> to Map<String, dynamic>
    final updateMap = <String, dynamic>{};
    for (var entry in contents) {
       updateMap[entry.key] = _convertDataEntryValue(entry.value);
    }

    DataBindingResolver.update(dataModel, path, updateMap);
    notifyListeners();
  }

  dynamic _convertDataEntryValue(dynamic value) {
     if (value is List) {
       // Check if it's a list of DataEntry (which comes from valueMap)
       if (value.isNotEmpty && value.first is DataEntry) {
          final map = <String, dynamic>{};
          for (var entry in value) {
             map[entry.key] = _convertDataEntryValue(entry.value);
          }
          return map;
       }
     }
     return value;
  }

  void beginRendering(String root) {
    rootId = root;
    isReady = true;
    notifyListeners();
  }
}

/// Global state manager for the A2UI client.
class A2UIState extends ChangeNotifier {
  final Map<String, SurfaceState> surfaces = {};

  SurfaceState getSurface(String surfaceId) {
    if (!surfaces.containsKey(surfaceId)) {
      surfaces[surfaceId] = SurfaceState(surfaceId);
      // Notify listeners that a new surface is available?
      notifyListeners();
    }
    return surfaces[surfaceId]!;
  }

  void removeSurface(String surfaceId) {
    surfaces.remove(surfaceId);
    notifyListeners();
  }

  void processMessage(A2UIMessage message) {
    if (message is SurfaceUpdate) {
      getSurface(message.surfaceId).updateComponents(message.components);
    } else if (message is DataModelUpdate) {
      getSurface(message.surfaceId).updateDataModel(message.path, message.contents);
    } else if (message is BeginRendering) {
      // BeginRendering might specify surfaceId, or imply 'default'
      final sid = message.surfaceId ?? 'default';
      getSurface(sid).beginRendering(message.rootId);
    }
  }
}
