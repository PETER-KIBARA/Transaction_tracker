// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AnalyticsEntity _$AnalyticsEntityFromJson(Map<String, dynamic> json) {
  return _AnalyticsEntity.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsEntity {
  int get id => throw _privateConstructorUsedError;
  DateTime get month => throw _privateConstructorUsedError;
  double get totalIncome => throw _privateConstructorUsedError;
  double get totalExpenses => throw _privateConstructorUsedError;
  double get savings => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AnalyticsEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsEntityCopyWith<AnalyticsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsEntityCopyWith<$Res> {
  factory $AnalyticsEntityCopyWith(
    AnalyticsEntity value,
    $Res Function(AnalyticsEntity) then,
  ) = _$AnalyticsEntityCopyWithImpl<$Res, AnalyticsEntity>;
  @useResult
  $Res call({
    int id,
    DateTime month,
    double totalIncome,
    double totalExpenses,
    double savings,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$AnalyticsEntityCopyWithImpl<$Res, $Val extends AnalyticsEntity>
    implements $AnalyticsEntityCopyWith<$Res> {
  _$AnalyticsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? month = null,
    Object? totalIncome = null,
    Object? totalExpenses = null,
    Object? savings = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalIncome: null == totalIncome
                ? _value.totalIncome
                : totalIncome // ignore: cast_nullable_to_non_nullable
                      as double,
            totalExpenses: null == totalExpenses
                ? _value.totalExpenses
                : totalExpenses // ignore: cast_nullable_to_non_nullable
                      as double,
            savings: null == savings
                ? _value.savings
                : savings // ignore: cast_nullable_to_non_nullable
                      as double,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalyticsEntityImplCopyWith<$Res>
    implements $AnalyticsEntityCopyWith<$Res> {
  factory _$$AnalyticsEntityImplCopyWith(
    _$AnalyticsEntityImpl value,
    $Res Function(_$AnalyticsEntityImpl) then,
  ) = __$$AnalyticsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    DateTime month,
    double totalIncome,
    double totalExpenses,
    double savings,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$AnalyticsEntityImplCopyWithImpl<$Res>
    extends _$AnalyticsEntityCopyWithImpl<$Res, _$AnalyticsEntityImpl>
    implements _$$AnalyticsEntityImplCopyWith<$Res> {
  __$$AnalyticsEntityImplCopyWithImpl(
    _$AnalyticsEntityImpl _value,
    $Res Function(_$AnalyticsEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? month = null,
    Object? totalIncome = null,
    Object? totalExpenses = null,
    Object? savings = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$AnalyticsEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalIncome: null == totalIncome
            ? _value.totalIncome
            : totalIncome // ignore: cast_nullable_to_non_nullable
                  as double,
        totalExpenses: null == totalExpenses
            ? _value.totalExpenses
            : totalExpenses // ignore: cast_nullable_to_non_nullable
                  as double,
        savings: null == savings
            ? _value.savings
            : savings // ignore: cast_nullable_to_non_nullable
                  as double,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsEntityImpl implements _AnalyticsEntity {
  const _$AnalyticsEntityImpl({
    required this.id,
    required this.month,
    required this.totalIncome,
    required this.totalExpenses,
    required this.savings,
    required this.updatedAt,
  });

  factory _$AnalyticsEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsEntityImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime month;
  @override
  final double totalIncome;
  @override
  final double totalExpenses;
  @override
  final double savings;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'AnalyticsEntity(id: $id, month: $month, totalIncome: $totalIncome, totalExpenses: $totalExpenses, savings: $savings, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.totalExpenses, totalExpenses) ||
                other.totalExpenses == totalExpenses) &&
            (identical(other.savings, savings) || other.savings == savings) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    month,
    totalIncome,
    totalExpenses,
    savings,
    updatedAt,
  );

  /// Create a copy of AnalyticsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsEntityImplCopyWith<_$AnalyticsEntityImpl> get copyWith =>
      __$$AnalyticsEntityImplCopyWithImpl<_$AnalyticsEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsEntityImplToJson(this);
  }
}

abstract class _AnalyticsEntity implements AnalyticsEntity {
  const factory _AnalyticsEntity({
    required final int id,
    required final DateTime month,
    required final double totalIncome,
    required final double totalExpenses,
    required final double savings,
    required final DateTime updatedAt,
  }) = _$AnalyticsEntityImpl;

  factory _AnalyticsEntity.fromJson(Map<String, dynamic> json) =
      _$AnalyticsEntityImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get month;
  @override
  double get totalIncome;
  @override
  double get totalExpenses;
  @override
  double get savings;
  @override
  DateTime get updatedAt;

  /// Create a copy of AnalyticsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsEntityImplCopyWith<_$AnalyticsEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
