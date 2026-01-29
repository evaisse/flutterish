// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schema_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdminConfig _$AdminConfigFromJson(Map<String, dynamic> json) {
  return _AdminConfig.fromJson(json);
}

/// @nodoc
mixin _$AdminConfig {
  String get title => throw _privateConstructorUsedError;
  List<ResourceConfig> get resources => throw _privateConstructorUsedError;
  String get layout => throw _privateConstructorUsedError;

  /// Serializes this AdminConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminConfigCopyWith<AdminConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminConfigCopyWith<$Res> {
  factory $AdminConfigCopyWith(
    AdminConfig value,
    $Res Function(AdminConfig) then,
  ) = _$AdminConfigCopyWithImpl<$Res, AdminConfig>;
  @useResult
  $Res call({String title, List<ResourceConfig> resources, String layout});
}

/// @nodoc
class _$AdminConfigCopyWithImpl<$Res, $Val extends AdminConfig>
    implements $AdminConfigCopyWith<$Res> {
  _$AdminConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? resources = null,
    Object? layout = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            resources: null == resources
                ? _value.resources
                : resources // ignore: cast_nullable_to_non_nullable
                      as List<ResourceConfig>,
            layout: null == layout
                ? _value.layout
                : layout // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminConfigImplCopyWith<$Res>
    implements $AdminConfigCopyWith<$Res> {
  factory _$$AdminConfigImplCopyWith(
    _$AdminConfigImpl value,
    $Res Function(_$AdminConfigImpl) then,
  ) = __$$AdminConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, List<ResourceConfig> resources, String layout});
}

/// @nodoc
class __$$AdminConfigImplCopyWithImpl<$Res>
    extends _$AdminConfigCopyWithImpl<$Res, _$AdminConfigImpl>
    implements _$$AdminConfigImplCopyWith<$Res> {
  __$$AdminConfigImplCopyWithImpl(
    _$AdminConfigImpl _value,
    $Res Function(_$AdminConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? resources = null,
    Object? layout = null,
  }) {
    return _then(
      _$AdminConfigImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        resources: null == resources
            ? _value._resources
            : resources // ignore: cast_nullable_to_non_nullable
                  as List<ResourceConfig>,
        layout: null == layout
            ? _value.layout
            : layout // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminConfigImpl implements _AdminConfig {
  const _$AdminConfigImpl({
    this.title = 'Admin',
    final List<ResourceConfig> resources = const [],
    this.layout = 'Layout',
  }) : _resources = resources;

  factory _$AdminConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminConfigImplFromJson(json);

  @override
  @JsonKey()
  final String title;
  final List<ResourceConfig> _resources;
  @override
  @JsonKey()
  List<ResourceConfig> get resources {
    if (_resources is EqualUnmodifiableListView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resources);
  }

  @override
  @JsonKey()
  final String layout;

  @override
  String toString() {
    return 'AdminConfig(title: $title, resources: $resources, layout: $layout)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminConfigImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(
              other._resources,
              _resources,
            ) &&
            (identical(other.layout, layout) || other.layout == layout));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    const DeepCollectionEquality().hash(_resources),
    layout,
  );

  /// Create a copy of AdminConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminConfigImplCopyWith<_$AdminConfigImpl> get copyWith =>
      __$$AdminConfigImplCopyWithImpl<_$AdminConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminConfigImplToJson(this);
  }
}

abstract class _AdminConfig implements AdminConfig {
  const factory _AdminConfig({
    final String title,
    final List<ResourceConfig> resources,
    final String layout,
  }) = _$AdminConfigImpl;

  factory _AdminConfig.fromJson(Map<String, dynamic> json) =
      _$AdminConfigImpl.fromJson;

  @override
  String get title;
  @override
  List<ResourceConfig> get resources;
  @override
  String get layout;

  /// Create a copy of AdminConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminConfigImplCopyWith<_$AdminConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ResourceConfig _$ResourceConfigFromJson(Map<String, dynamic> json) {
  return _ResourceConfig.fromJson(json);
}

/// @nodoc
mixin _$ResourceConfig {
  String get name => throw _privateConstructorUsedError;
  ComponentConfig? get list => throw _privateConstructorUsedError;
  ComponentConfig? get edit => throw _privateConstructorUsedError;
  ComponentConfig? get create => throw _privateConstructorUsedError;
  ComponentConfig? get show => throw _privateConstructorUsedError;

  /// Serializes this ResourceConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResourceConfigCopyWith<ResourceConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResourceConfigCopyWith<$Res> {
  factory $ResourceConfigCopyWith(
    ResourceConfig value,
    $Res Function(ResourceConfig) then,
  ) = _$ResourceConfigCopyWithImpl<$Res, ResourceConfig>;
  @useResult
  $Res call({
    String name,
    ComponentConfig? list,
    ComponentConfig? edit,
    ComponentConfig? create,
    ComponentConfig? show,
  });

  $ComponentConfigCopyWith<$Res>? get list;
  $ComponentConfigCopyWith<$Res>? get edit;
  $ComponentConfigCopyWith<$Res>? get create;
  $ComponentConfigCopyWith<$Res>? get show;
}

/// @nodoc
class _$ResourceConfigCopyWithImpl<$Res, $Val extends ResourceConfig>
    implements $ResourceConfigCopyWith<$Res> {
  _$ResourceConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? list = freezed,
    Object? edit = freezed,
    Object? create = freezed,
    Object? show = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            list: freezed == list
                ? _value.list
                : list // ignore: cast_nullable_to_non_nullable
                      as ComponentConfig?,
            edit: freezed == edit
                ? _value.edit
                : edit // ignore: cast_nullable_to_non_nullable
                      as ComponentConfig?,
            create: freezed == create
                ? _value.create
                : create // ignore: cast_nullable_to_non_nullable
                      as ComponentConfig?,
            show: freezed == show
                ? _value.show
                : show // ignore: cast_nullable_to_non_nullable
                      as ComponentConfig?,
          )
          as $Val,
    );
  }

  /// Create a copy of ResourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComponentConfigCopyWith<$Res>? get list {
    if (_value.list == null) {
      return null;
    }

    return $ComponentConfigCopyWith<$Res>(_value.list!, (value) {
      return _then(_value.copyWith(list: value) as $Val);
    });
  }

  /// Create a copy of ResourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComponentConfigCopyWith<$Res>? get edit {
    if (_value.edit == null) {
      return null;
    }

    return $ComponentConfigCopyWith<$Res>(_value.edit!, (value) {
      return _then(_value.copyWith(edit: value) as $Val);
    });
  }

  /// Create a copy of ResourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComponentConfigCopyWith<$Res>? get create {
    if (_value.create == null) {
      return null;
    }

    return $ComponentConfigCopyWith<$Res>(_value.create!, (value) {
      return _then(_value.copyWith(create: value) as $Val);
    });
  }

  /// Create a copy of ResourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComponentConfigCopyWith<$Res>? get show {
    if (_value.show == null) {
      return null;
    }

    return $ComponentConfigCopyWith<$Res>(_value.show!, (value) {
      return _then(_value.copyWith(show: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ResourceConfigImplCopyWith<$Res>
    implements $ResourceConfigCopyWith<$Res> {
  factory _$$ResourceConfigImplCopyWith(
    _$ResourceConfigImpl value,
    $Res Function(_$ResourceConfigImpl) then,
  ) = __$$ResourceConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    ComponentConfig? list,
    ComponentConfig? edit,
    ComponentConfig? create,
    ComponentConfig? show,
  });

  @override
  $ComponentConfigCopyWith<$Res>? get list;
  @override
  $ComponentConfigCopyWith<$Res>? get edit;
  @override
  $ComponentConfigCopyWith<$Res>? get create;
  @override
  $ComponentConfigCopyWith<$Res>? get show;
}

/// @nodoc
class __$$ResourceConfigImplCopyWithImpl<$Res>
    extends _$ResourceConfigCopyWithImpl<$Res, _$ResourceConfigImpl>
    implements _$$ResourceConfigImplCopyWith<$Res> {
  __$$ResourceConfigImplCopyWithImpl(
    _$ResourceConfigImpl _value,
    $Res Function(_$ResourceConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? list = freezed,
    Object? edit = freezed,
    Object? create = freezed,
    Object? show = freezed,
  }) {
    return _then(
      _$ResourceConfigImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        list: freezed == list
            ? _value.list
            : list // ignore: cast_nullable_to_non_nullable
                  as ComponentConfig?,
        edit: freezed == edit
            ? _value.edit
            : edit // ignore: cast_nullable_to_non_nullable
                  as ComponentConfig?,
        create: freezed == create
            ? _value.create
            : create // ignore: cast_nullable_to_non_nullable
                  as ComponentConfig?,
        show: freezed == show
            ? _value.show
            : show // ignore: cast_nullable_to_non_nullable
                  as ComponentConfig?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ResourceConfigImpl implements _ResourceConfig {
  const _$ResourceConfigImpl({
    required this.name,
    this.list,
    this.edit,
    this.create,
    this.show,
  });

  factory _$ResourceConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResourceConfigImplFromJson(json);

  @override
  final String name;
  @override
  final ComponentConfig? list;
  @override
  final ComponentConfig? edit;
  @override
  final ComponentConfig? create;
  @override
  final ComponentConfig? show;

  @override
  String toString() {
    return 'ResourceConfig(name: $name, list: $list, edit: $edit, create: $create, show: $show)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResourceConfigImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.list, list) || other.list == list) &&
            (identical(other.edit, edit) || other.edit == edit) &&
            (identical(other.create, create) || other.create == create) &&
            (identical(other.show, show) || other.show == show));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, list, edit, create, show);

  /// Create a copy of ResourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResourceConfigImplCopyWith<_$ResourceConfigImpl> get copyWith =>
      __$$ResourceConfigImplCopyWithImpl<_$ResourceConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ResourceConfigImplToJson(this);
  }
}

abstract class _ResourceConfig implements ResourceConfig {
  const factory _ResourceConfig({
    required final String name,
    final ComponentConfig? list,
    final ComponentConfig? edit,
    final ComponentConfig? create,
    final ComponentConfig? show,
  }) = _$ResourceConfigImpl;

  factory _ResourceConfig.fromJson(Map<String, dynamic> json) =
      _$ResourceConfigImpl.fromJson;

  @override
  String get name;
  @override
  ComponentConfig? get list;
  @override
  ComponentConfig? get edit;
  @override
  ComponentConfig? get create;
  @override
  ComponentConfig? get show;

  /// Create a copy of ResourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResourceConfigImplCopyWith<_$ResourceConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComponentConfig _$ComponentConfigFromJson(Map<String, dynamic> json) {
  return _ComponentConfig.fromJson(json);
}

/// @nodoc
mixin _$ComponentConfig {
  String get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get props => throw _privateConstructorUsedError;
  List<ComponentConfig> get children => throw _privateConstructorUsedError;

  /// Serializes this ComponentConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ComponentConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ComponentConfigCopyWith<ComponentConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComponentConfigCopyWith<$Res> {
  factory $ComponentConfigCopyWith(
    ComponentConfig value,
    $Res Function(ComponentConfig) then,
  ) = _$ComponentConfigCopyWithImpl<$Res, ComponentConfig>;
  @useResult
  $Res call({
    String type,
    Map<String, dynamic> props,
    List<ComponentConfig> children,
  });
}

/// @nodoc
class _$ComponentConfigCopyWithImpl<$Res, $Val extends ComponentConfig>
    implements $ComponentConfigCopyWith<$Res> {
  _$ComponentConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ComponentConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? props = null,
    Object? children = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            props: null == props
                ? _value.props
                : props // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            children: null == children
                ? _value.children
                : children // ignore: cast_nullable_to_non_nullable
                      as List<ComponentConfig>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ComponentConfigImplCopyWith<$Res>
    implements $ComponentConfigCopyWith<$Res> {
  factory _$$ComponentConfigImplCopyWith(
    _$ComponentConfigImpl value,
    $Res Function(_$ComponentConfigImpl) then,
  ) = __$$ComponentConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    Map<String, dynamic> props,
    List<ComponentConfig> children,
  });
}

/// @nodoc
class __$$ComponentConfigImplCopyWithImpl<$Res>
    extends _$ComponentConfigCopyWithImpl<$Res, _$ComponentConfigImpl>
    implements _$$ComponentConfigImplCopyWith<$Res> {
  __$$ComponentConfigImplCopyWithImpl(
    _$ComponentConfigImpl _value,
    $Res Function(_$ComponentConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComponentConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? props = null,
    Object? children = null,
  }) {
    return _then(
      _$ComponentConfigImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        props: null == props
            ? _value._props
            : props // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        children: null == children
            ? _value._children
            : children // ignore: cast_nullable_to_non_nullable
                  as List<ComponentConfig>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ComponentConfigImpl implements _ComponentConfig {
  const _$ComponentConfigImpl({
    required this.type,
    final Map<String, dynamic> props = const {},
    final List<ComponentConfig> children = const [],
  }) : _props = props,
       _children = children;

  factory _$ComponentConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComponentConfigImplFromJson(json);

  @override
  final String type;
  final Map<String, dynamic> _props;
  @override
  @JsonKey()
  Map<String, dynamic> get props {
    if (_props is EqualUnmodifiableMapView) return _props;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_props);
  }

  final List<ComponentConfig> _children;
  @override
  @JsonKey()
  List<ComponentConfig> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  String toString() {
    return 'ComponentConfig(type: $type, props: $props, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComponentConfigImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._props, _props) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    const DeepCollectionEquality().hash(_props),
    const DeepCollectionEquality().hash(_children),
  );

  /// Create a copy of ComponentConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ComponentConfigImplCopyWith<_$ComponentConfigImpl> get copyWith =>
      __$$ComponentConfigImplCopyWithImpl<_$ComponentConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ComponentConfigImplToJson(this);
  }
}

abstract class _ComponentConfig implements ComponentConfig {
  const factory _ComponentConfig({
    required final String type,
    final Map<String, dynamic> props,
    final List<ComponentConfig> children,
  }) = _$ComponentConfigImpl;

  factory _ComponentConfig.fromJson(Map<String, dynamic> json) =
      _$ComponentConfigImpl.fromJson;

  @override
  String get type;
  @override
  Map<String, dynamic> get props;
  @override
  List<ComponentConfig> get children;

  /// Create a copy of ComponentConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ComponentConfigImplCopyWith<_$ComponentConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
