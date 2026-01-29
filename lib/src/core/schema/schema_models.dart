import 'package:freezed_annotation/freezed_annotation.dart';

part 'schema_models.freezed.dart';
part 'schema_models.g.dart';

@freezed
class AdminConfig with _$AdminConfig {
  const factory AdminConfig({
    @Default('Admin') String title,
    @Default([]) List<ResourceConfig> resources,
    @Default('Layout') String layout,
  }) = _AdminConfig;

  factory AdminConfig.fromJson(Map<String, dynamic> json) => _$AdminConfigFromJson(json);
}

@freezed
class ResourceConfig with _$ResourceConfig {
  const factory ResourceConfig({
    required String name,
    ComponentConfig? list,
    ComponentConfig? edit,
    ComponentConfig? create,
    ComponentConfig? show,
  }) = _ResourceConfig;

  factory ResourceConfig.fromJson(Map<String, dynamic> json) => _$ResourceConfigFromJson(json);
}

@freezed
class ComponentConfig with _$ComponentConfig {
  const factory ComponentConfig({
    required String type,
    @Default({}) Map<String, dynamic> props,
    @Default([]) List<ComponentConfig> children,
  }) = _ComponentConfig;

  factory ComponentConfig.fromJson(Map<String, dynamic> json) => _$ComponentConfigFromJson(json);
}
