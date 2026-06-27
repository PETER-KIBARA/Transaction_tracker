import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';

part 'sms_transaction_model.freezed.dart';
part 'sms_transaction_model.g.dart';

/// Model for SMS transaction data layer
@freezed
class SmsTransactionModel with _$SmsTransactionModel {
  const SmsTransactionModel._();

  const factory SmsTransactionModel({
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
  }) = _SmsTransactionModel;

  factory SmsTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$SmsTransactionModelFromJson(json);

  /// Convert model to entity
  SmsTransactionEntity toEntity() {
    return SmsTransactionEntity(
      id: id,
      sender: sender,
      messageBody: messageBody,
      amount: amount,
      transactionType: transactionType,
      category: category,
      transactionDate: transactionDate,
      balance: balance,
      referenceNumber: referenceNumber,
      createdAt: createdAt,
    );
  }

  /// Create model from entity
  factory SmsTransactionModel.fromEntity(SmsTransactionEntity entity) {
    return SmsTransactionModel(
      id: entity.id,
      sender: entity.sender,
      messageBody: entity.messageBody,
      amount: entity.amount,
      transactionType: entity.transactionType,
      category: entity.category,
      transactionDate: entity.transactionDate,
      balance: entity.balance,
      referenceNumber: entity.referenceNumber,
      createdAt: entity.createdAt,
    );
  }
}
