// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_transaction_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmsTransactionEntityImpl _$$SmsTransactionEntityImplFromJson(
  Map<String, dynamic> json,
) => _$SmsTransactionEntityImpl(
  id: json['id'] as String,
  sender: json['sender'] as String,
  messageBody: json['messageBody'] as String,
  amount: (json['amount'] as num).toDouble(),
  transactionType: json['transactionType'] as String,
  category: json['category'] as String,
  transactionDate: DateTime.parse(json['transactionDate'] as String),
  balance: (json['balance'] as num?)?.toDouble(),
  referenceNumber: json['referenceNumber'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$SmsTransactionEntityImplToJson(
  _$SmsTransactionEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sender': instance.sender,
  'messageBody': instance.messageBody,
  'amount': instance.amount,
  'transactionType': instance.transactionType,
  'category': instance.category,
  'transactionDate': instance.transactionDate.toIso8601String(),
  'balance': instance.balance,
  'referenceNumber': instance.referenceNumber,
  'createdAt': instance.createdAt.toIso8601String(),
};
