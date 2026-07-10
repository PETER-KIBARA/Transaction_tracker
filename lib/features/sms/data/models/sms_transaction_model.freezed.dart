// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SmsTransactionModel _$SmsTransactionModelFromJson(Map<String, dynamic> json) {
  return _SmsTransactionModel.fromJson(json);
}

/// @nodoc
mixin _$SmsTransactionModel {
  String get id => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get messageBody => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get transactionType => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  DateTime get transactionDate => throw _privateConstructorUsedError;
  TransactionProvider get provider => throw _privateConstructorUsedError;
  double? get transactionCost => throw _privateConstructorUsedError;
  double? get balance => throw _privateConstructorUsedError;
  String? get referenceNumber => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SmsTransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmsTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsTransactionModelCopyWith<SmsTransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsTransactionModelCopyWith<$Res> {
  factory $SmsTransactionModelCopyWith(
    SmsTransactionModel value,
    $Res Function(SmsTransactionModel) then,
  ) = _$SmsTransactionModelCopyWithImpl<$Res, SmsTransactionModel>;
  @useResult
  $Res call({
    String id,
    String sender,
    String messageBody,
    double amount,
    String transactionType,
    String category,
    DateTime transactionDate,
    TransactionProvider provider,
    double? transactionCost,
    double? balance,
    String? referenceNumber,
    DateTime createdAt,
  });
}

/// @nodoc
class _$SmsTransactionModelCopyWithImpl<$Res, $Val extends SmsTransactionModel>
    implements $SmsTransactionModelCopyWith<$Res> {
  _$SmsTransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? messageBody = null,
    Object? amount = null,
    Object? transactionType = null,
    Object? category = null,
    Object? transactionDate = null,
    Object? provider = null,
    Object? transactionCost = freezed,
    Object? balance = freezed,
    Object? referenceNumber = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sender: null == sender
                ? _value.sender
                : sender // ignore: cast_nullable_to_non_nullable
                      as String,
            messageBody: null == messageBody
                ? _value.messageBody
                : messageBody // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            transactionType: null == transactionType
                ? _value.transactionType
                : transactionType // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            transactionDate: null == transactionDate
                ? _value.transactionDate
                : transactionDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as TransactionProvider,
            transactionCost: freezed == transactionCost
                ? _value.transactionCost
                : transactionCost // ignore: cast_nullable_to_non_nullable
                      as double?,
            balance: freezed == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as double?,
            referenceNumber: freezed == referenceNumber
                ? _value.referenceNumber
                : referenceNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmsTransactionModelImplCopyWith<$Res>
    implements $SmsTransactionModelCopyWith<$Res> {
  factory _$$SmsTransactionModelImplCopyWith(
    _$SmsTransactionModelImpl value,
    $Res Function(_$SmsTransactionModelImpl) then,
  ) = __$$SmsTransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String sender,
    String messageBody,
    double amount,
    String transactionType,
    String category,
    DateTime transactionDate,
    TransactionProvider provider,
    double? transactionCost,
    double? balance,
    String? referenceNumber,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$SmsTransactionModelImplCopyWithImpl<$Res>
    extends _$SmsTransactionModelCopyWithImpl<$Res, _$SmsTransactionModelImpl>
    implements _$$SmsTransactionModelImplCopyWith<$Res> {
  __$$SmsTransactionModelImplCopyWithImpl(
    _$SmsTransactionModelImpl _value,
    $Res Function(_$SmsTransactionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmsTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? messageBody = null,
    Object? amount = null,
    Object? transactionType = null,
    Object? category = null,
    Object? transactionDate = null,
    Object? provider = null,
    Object? transactionCost = freezed,
    Object? balance = freezed,
    Object? referenceNumber = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$SmsTransactionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sender: null == sender
            ? _value.sender
            : sender // ignore: cast_nullable_to_non_nullable
                  as String,
        messageBody: null == messageBody
            ? _value.messageBody
            : messageBody // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        transactionType: null == transactionType
            ? _value.transactionType
            : transactionType // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionDate: null == transactionDate
            ? _value.transactionDate
            : transactionDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as TransactionProvider,
        transactionCost: freezed == transactionCost
            ? _value.transactionCost
            : transactionCost // ignore: cast_nullable_to_non_nullable
                  as double?,
        balance: freezed == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as double?,
        referenceNumber: freezed == referenceNumber
            ? _value.referenceNumber
            : referenceNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsTransactionModelImpl extends _SmsTransactionModel {
  const _$SmsTransactionModelImpl({
    required this.id,
    required this.sender,
    required this.messageBody,
    required this.amount,
    required this.transactionType,
    required this.category,
    required this.transactionDate,
    this.provider = TransactionProvider.unknown,
    this.transactionCost,
    this.balance,
    this.referenceNumber,
    required this.createdAt,
  }) : super._();

  factory _$SmsTransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsTransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String sender;
  @override
  final String messageBody;
  @override
  final double amount;
  @override
  final String transactionType;
  @override
  final String category;
  @override
  final DateTime transactionDate;
  @override
  @JsonKey()
  final TransactionProvider provider;
  @override
  final double? transactionCost;
  @override
  final double? balance;
  @override
  final String? referenceNumber;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'SmsTransactionModel(id: $id, sender: $sender, messageBody: $messageBody, amount: $amount, transactionType: $transactionType, category: $category, transactionDate: $transactionDate, provider: $provider, transactionCost: $transactionCost, balance: $balance, referenceNumber: $referenceNumber, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsTransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.messageBody, messageBody) ||
                other.messageBody == messageBody) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.transactionCost, transactionCost) ||
                other.transactionCost == transactionCost) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sender,
    messageBody,
    amount,
    transactionType,
    category,
    transactionDate,
    provider,
    transactionCost,
    balance,
    referenceNumber,
    createdAt,
  );

  /// Create a copy of SmsTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsTransactionModelImplCopyWith<_$SmsTransactionModelImpl> get copyWith =>
      __$$SmsTransactionModelImplCopyWithImpl<_$SmsTransactionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsTransactionModelImplToJson(this);
  }
}

abstract class _SmsTransactionModel extends SmsTransactionModel {
  const factory _SmsTransactionModel({
    required final String id,
    required final String sender,
    required final String messageBody,
    required final double amount,
    required final String transactionType,
    required final String category,
    required final DateTime transactionDate,
    final TransactionProvider provider,
    final double? transactionCost,
    final double? balance,
    final String? referenceNumber,
    required final DateTime createdAt,
  }) = _$SmsTransactionModelImpl;
  const _SmsTransactionModel._() : super._();

  factory _SmsTransactionModel.fromJson(Map<String, dynamic> json) =
      _$SmsTransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get sender;
  @override
  String get messageBody;
  @override
  double get amount;
  @override
  String get transactionType;
  @override
  String get category;
  @override
  DateTime get transactionDate;
  @override
  TransactionProvider get provider;
  @override
  double? get transactionCost;
  @override
  double? get balance;
  @override
  String? get referenceNumber;
  @override
  DateTime get createdAt;

  /// Create a copy of SmsTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsTransactionModelImplCopyWith<_$SmsTransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
