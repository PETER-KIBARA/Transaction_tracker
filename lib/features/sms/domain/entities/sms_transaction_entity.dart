import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_transaction_entity.freezed.dart';
part 'sms_transaction_entity.g.dart';

enum TransactionProvider { mpesa, airtel, equity, unknown }

/// Resolves the financial provider without making the parser depend on a
/// particular SMS template. The body is considered for legacy messages whose
/// sender was rewritten by a device or network.
TransactionProvider detectTransactionProvider({
  required String sender,
  String? messageBody,
}) {
  final value = '$sender ${messageBody ?? ''}'.toUpperCase().replaceAll(
    RegExp(r'[^A-Z]'),
    '',
  );
  if (value.contains('MPESA') || value.contains('SAFARICOM')) {
    return TransactionProvider.mpesa;
  }
  if (value.contains('AIRTEL') || value.contains('AIRTELMONEY')) {
    return TransactionProvider.airtel;
  }
  if (value.contains('EQUITY') || value.contains('EQUITYBANK')) {
    return TransactionProvider.equity;
  }
  return TransactionProvider.unknown;
}

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
    @Default(TransactionProvider.unknown) TransactionProvider provider,
    double? transactionCost,
    double? balance,
    String? referenceNumber,
    required DateTime createdAt,
  }) = _SmsTransactionEntity;

  factory SmsTransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$SmsTransactionEntityFromJson(json);
}
