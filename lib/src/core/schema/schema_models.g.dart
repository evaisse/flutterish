// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminConfigImpl _$$AdminConfigImplFromJson(Map<String, dynamic> json) =>
    _$AdminConfigImpl(
      title: json['title'] as String? ?? 'Admin',
      resources:
          (json['resources'] as List<dynamic>?)
              ?.map((e) => ResourceConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      layout: json['layout'] as String? ?? 'Layout',
    );

Map<String, dynamic> _$$AdminConfigImplToJson(_$AdminConfigImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'resources': instance.resources.map((e) => e.toJson()).toList(),
      'layout': instance.layout,
    };

_$ResourceConfigImpl _$$ResourceConfigImplFromJson(Map<String, dynamic> json) =>
    _$ResourceConfigImpl(
      name: json['name'] as String,
      list: json['list'] == null
          ? null
          : ComponentConfig.fromJson(json['list'] as Map<String, dynamic>),
      edit: json['edit'] == null
          ? null
          : ComponentConfig.fromJson(json['edit'] as Map<String, dynamic>),
      create: json['create'] == null
          ? null
          : ComponentConfig.fromJson(json['create'] as Map<String, dynamic>),
      show: json['show'] == null
          ? null
          : ComponentConfig.fromJson(json['show'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ResourceConfigImplToJson(
  _$ResourceConfigImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'list': instance.list?.toJson(),
  'edit': instance.edit?.toJson(),
  'create': instance.create?.toJson(),
  'show': instance.show?.toJson(),
};

_$ComponentConfigImpl _$$ComponentConfigImplFromJson(
  Map<String, dynamic> json,
) => _$ComponentConfigImpl(
  type: json['type'] as String,
  props: json['props'] as Map<String, dynamic>? ?? const {},
  children:
      (json['children'] as List<dynamic>?)
          ?.map((e) => ComponentConfig.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$ComponentConfigImplToJson(
  _$ComponentConfigImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'props': instance.props,
  'children': instance.children.map((e) => e.toJson()).toList(),
};
