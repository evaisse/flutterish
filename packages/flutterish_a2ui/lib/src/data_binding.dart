/// Resolves paths against a data model.
class DataBindingResolver {

  /// Resolves a path like "/user/name" against the data model.
  static dynamic resolve(Map<String, dynamic> dataModel, String path) {
    if (path.isEmpty) return null;
    if (path == '/') return dataModel;

    final parts = path.split('/').where((p) => p.isNotEmpty).toList();
    dynamic current = dataModel;

    for (final part in parts) {
      if (current is Map) {
        if (!current.containsKey(part)) return null;
        current = current[part];
      } else {
        return null;
      }
    }
    return current;
  }

  /// Updates the data model at the specified path.
  /// This mutates the map.
  static void update(Map<String, dynamic> dataModel, String? path, Map<String, dynamic> updates) {
    if (path == null || path == '/' || path.isEmpty) {
      _merge(dataModel, updates);
      return;
    }

    final parts = path.split('/').where((p) => p.isNotEmpty).toList();
    dynamic current = dataModel;

    // Navigate to the parent of the target
    for (int i = 0; i < parts.length; i++) {
      final part = parts[i];
      if (current is! Map) return; // Cannot traverse

      if (!current.containsKey(part)) {
        current[part] = <String, dynamic>{};
      }
      current = current[part];
    }

    // Now 'current' is the target object. Merge updates.
    if (current is Map<String, dynamic>) {
      _merge(current, updates);
    }
  }

  static void _merge(Map<String, dynamic> target, Map<String, dynamic> source) {
     for (var key in source.keys) {
       target[key] = source[key];
     }
  }
}

/// Helper for handling BoundValue objects from component properties
class BoundValue {
  final String? literalString;
  final num? literalNumber;
  final bool? literalBoolean;
  final List? literalArray;
  final String? path;

  BoundValue({
    this.literalString,
    this.literalNumber,
    this.literalBoolean,
    this.literalArray,
    this.path,
  });

  factory BoundValue.fromJson(Map<String, dynamic> json) {
    return BoundValue(
      literalString: json['literalString'],
      literalNumber: json['literalNumber'],
      literalBoolean: json['literalBoolean'],
      literalArray: json['literalArray'],
      path: json['path'], // path might be a string or object ref, spec says string usually?
      // Spec says: "path": { "$ref": "#/definitions/DataPath" } which is usually a string.
    );
  }

  dynamic resolve(Map<String, dynamic> dataModel) {
    // Priority:
    // If literal only -> return literal
    // If path only -> resolve path
    // If both -> return literal (initialization happened elsewhere ideally, or we treat it as current value)

    // Spec says: "If both path and a literal* value are provided... it serves as a shorthand for data model initialization."
    // Ideally the State manager handles initialization.
    // For rendering, we prefer the Path value if available in the model?
    // Actually, if it initialized the model, the model has the value.
    // So we should check the model first if path exists.

    if (path != null) {
      final resolved = DataBindingResolver.resolve(dataModel, path!);
      if (resolved != null) return resolved;
    }

    if (literalString != null) return literalString;
    if (literalNumber != null) return literalNumber;
    if (literalBoolean != null) return literalBoolean;
    if (literalArray != null) return literalArray;

    return null;
  }
}
