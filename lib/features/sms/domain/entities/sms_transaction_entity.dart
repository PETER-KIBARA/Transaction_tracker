import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_transaction_entity.freezed.dart';
part 'sms_transaction_entity.g.dart';

/// Entity representing an SMS transaction
@freezed
class SmsTransactionEntity with _$SmsTransactionEntity {
  const factory SmsTransactionEntity({
    required String id,
    required String sender,
    required String messageBody,
    required double amount,
    required String transactionType,
    required String category,
    required DateTime transactionDate,
    double? balance,
    String? referenceNumber,
    required DateTime createdAt,
  }) = _SmsTransactionEntity;

  factory SmsTransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$SmsTransactionEntityFromJson(json);
}
