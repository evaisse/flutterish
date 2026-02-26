/// Represents a message from the server to the client.
sealed class A2UIMessage {}

class SurfaceUpdate extends A2UIMessage {
  final String surfaceId;
  final List<ComponentDefinition> components;

  SurfaceUpdate({required this.surfaceId, required this.components});

  factory SurfaceUpdate.fromJson(Map<String, dynamic> json) {
    final componentsList = (json['components'] as List)
        .map((e) => ComponentDefinition.fromJson(e as Map<String, dynamic>))
        .toList();
    return SurfaceUpdate(
      surfaceId: json['surfaceId'] ?? 'default', // Spec says surfaceId is required, but example omitted it sometimes? Spec says required.
      components: componentsList,
    );
  }
}

class DataModelUpdate extends A2UIMessage {
  final String surfaceId;
  final String? path;
  final List<DataEntry> contents;

  DataModelUpdate({
    required this.surfaceId,
    this.path,
    required this.contents,
  });

  factory DataModelUpdate.fromJson(Map<String, dynamic> json) {
    return DataModelUpdate(
      surfaceId: json['surfaceId'] ?? 'default',
      path: json['path'] as String?,
      contents: (json['contents'] as List? ?? [])
          .map((e) => DataEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class BeginRendering extends A2UIMessage {
  final String rootId;
  final String? surfaceId;
  final String? catalogId;

  BeginRendering({
    required this.rootId,
    this.surfaceId,
    this.catalogId,
  });

  factory BeginRendering.fromJson(Map<String, dynamic> json) {
    return BeginRendering(
      rootId: json['root'] as String,
      surfaceId: json['surfaceId'] as String?,
      catalogId: json['catalogId'] as String?,
    );
  }
}

class ComponentDefinition {
  final String id;
  final String type;
  final Map<String, dynamic> properties;

  ComponentDefinition({
    required this.id,
    required this.type,
    required this.properties,
  });

  factory ComponentDefinition.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final componentMap = json['component'] as Map<String, dynamic>;
    final type = componentMap.keys.first;
    final properties = componentMap[type] as Map<String, dynamic>;
    return ComponentDefinition(id: id, type: type, properties: properties);
  }
}

class DataEntry {
  final String key;
  final dynamic value;

  DataEntry({required this.key, required this.value});

  factory DataEntry.fromJson(Map<String, dynamic> json) {
    final key = json['key'] as String;
    // valueString, valueBoolean, valueNumber, valueMap
    dynamic value;
    if (json.containsKey('valueString')) {
      value = json['valueString'];
    } else if (json.containsKey('valueBoolean')) {
      value = json['valueBoolean'];
    } else if (json.containsKey('valueNumber')) {
      value = json['valueNumber'];
    } else if (json.containsKey('valueMap')) {
       // Recursive parsing for map
       value = (json['valueMap'] as List)
          .map((e) => DataEntry.fromJson(e))
          .toList(); // This format is slightly awkward for internal Map usage, handled in State
    }
    return DataEntry(key: key, value: value);
  }
}

/// Client to Server message
class UserAction {
  final String name;
  final String surfaceId;
  final String sourceComponentId;
  final String timestamp;
  final Map<String, dynamic> context;

  UserAction({
    required this.name,
    required this.surfaceId,
    required this.sourceComponentId,
    required this.timestamp,
    required this.context,
  });

  Map<String, dynamic> toJson() {
    return {
      'userAction': {
        'name': name,
        'surfaceId': surfaceId,
        'sourceComponentId': sourceComponentId,
        'timestamp': timestamp,
        'context': context,
      }
    };
  }
}
