// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlist_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WishlistModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  /// Create a copy of WishlistModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WishlistModelCopyWith<WishlistModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishlistModelCopyWith<$Res> {
  factory $WishlistModelCopyWith(
          WishlistModel value, $Res Function(WishlistModel) then) =
      _$WishlistModelCopyWithImpl<$Res, WishlistModel>;
  @useResult
  $Res call({String id, String name, double price, String imageUrl});
}

/// @nodoc
class _$WishlistModelCopyWithImpl<$Res, $Val extends WishlistModel>
    implements $WishlistModelCopyWith<$Res> {
  _$WishlistModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WishlistModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WishlistModelImplCopyWith<$Res>
    implements $WishlistModelCopyWith<$Res> {
  factory _$$WishlistModelImplCopyWith(
          _$WishlistModelImpl value, $Res Function(_$WishlistModelImpl) then) =
      __$$WishlistModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, double price, String imageUrl});
}

/// @nodoc
class __$$WishlistModelImplCopyWithImpl<$Res>
    extends _$WishlistModelCopyWithImpl<$Res, _$WishlistModelImpl>
    implements _$$WishlistModelImplCopyWith<$Res> {
  __$$WishlistModelImplCopyWithImpl(
      _$WishlistModelImpl _value, $Res Function(_$WishlistModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WishlistModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? imageUrl = null,
  }) {
    return _then(_$WishlistModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WishlistModelImpl
    with DiagnosticableTreeMixin
    implements _WishlistModel {
  const _$WishlistModelImpl(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl});

  @override
  final String id;
  @override
  final String name;
  @override
  final double price;
  @override
  final String imageUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WishlistModel(id: $id, name: $name, price: $price, imageUrl: $imageUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WishlistModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('imageUrl', imageUrl));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishlistModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, price, imageUrl);

  /// Create a copy of WishlistModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WishlistModelImplCopyWith<_$WishlistModelImpl> get copyWith =>
      __$$WishlistModelImplCopyWithImpl<_$WishlistModelImpl>(this, _$identity);
}

abstract class _WishlistModel implements WishlistModel {
  const factory _WishlistModel(
      {required final String id,
      required final String name,
      required final double price,
      required final String imageUrl}) = _$WishlistModelImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  double get price;
  @override
  String get imageUrl;

  /// Create a copy of WishlistModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WishlistModelImplCopyWith<_$WishlistModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
