// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmsTransactionModelImpl _$$SmsTransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$SmsTransactionModelImpl(
  id: json['id'] as String,
  sender: json['sender'] as String,
  messageBody: json['messageBody'] as String,
  amount: (json['amount'] as num).toDouble(),
  transactionType: json['transactionType'] as String,
  category: json['category'] as String,
  transactionDate: DateTime.parse(json['transactionDate'] as String),
  provider:
      $enumDecodeNullable(_$TransactionProviderEnumMap, json['provider']) ??
      TransactionProvider.unknown,
  transactionCost: (json['transactionCost'] as num?)?.toDouble(),
  balance: (json['balance'] as num?)?.toDouble(),
  referenceNumber: json['referenceNumber'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$SmsTransactionModelImplToJson(
  _$SmsTransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sender': instance.sender,
  'messageBody': instance.messageBody,
  'amount': instance.amount,
  'transactionType': instance.transactionType,
  'category': instance.category,
  'transactionDate': instance.transactionDate.toIso8601String(),
  'provider': _$TransactionProviderEnumMap[instance.provider]!,
  'transactionCost': instance.transactionCost,
  'balance': instance.balance,
  'referenceNumber': instance.referenceNumber,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$TransactionProviderEnumMap = {
  TransactionProvider.mpesa: 'mpesa',
  TransactionProvider.airtel: 'airtel',
  TransactionProvider.equity: 'equity',
  TransactionProvider.unknown: 'unknown',
};
