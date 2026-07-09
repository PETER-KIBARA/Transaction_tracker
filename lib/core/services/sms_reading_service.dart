import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:transaction_tracker/core/constants/app_constants.dart';
import 'package:transaction_tracker/core/errors/exceptions.dart';

/// Model for raw SMS data
class RawSmsMessage {
  final String messageBody;
  final String sender;
  final DateTime? timestamp;

  RawSmsMessage({
    required this.messageBody,
    required this.sender,
    this.timestamp,
  });
}

/// Service for reading SMS messages from device
class SmsReadingService {
  final SmsQuery _query = SmsQuery();

  /// Get all SMS messages from device
  Future<List<RawSmsMessage>> getAllSms() async {
    try {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
        count: 10000,
      );

      return messages.map((sms) {
        return RawSmsMessage(
          messageBody: sms.body ?? '',
          sender: sms.address ?? 'Unknown', // ← fixed: was sms.sender
          timestamp: sms.date,
        );
      }).toList();
    } catch (e) {
      throw SmsReadingException('Failed to read SMS messages: $e');
    }
  }

  /// Get SMS messages with optional date range filter
  Future<List<RawSmsMessage>> getSmsInDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
        count: 10000,
      );

      final filtered = messages.where((sms) {
        final smsDate = sms.date;
        if (smsDate == null) return false;
        return smsDate.isAfter(startDate) && smsDate.isBefore(endDate);
      }).toList();

      return filtered.map((sms) {
        return RawSmsMessage(
          messageBody: sms.body ?? '',
          sender: sms.address ?? 'Unknown',
          timestamp: sms.date,
        );
      }).toList();
    } catch (e) {
      throw SmsReadingException('Failed to filter SMS by date: $e');
    }
  }

  /// Get SMS messages from a specific sender
  Future<List<RawSmsMessage>> getSmsFromSender(String sender) async {
    try {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
        count: 10000,
      );

      final filtered = messages.where((sms) =>
          (sms.address ?? '').toLowerCase().contains(sender.toLowerCase()),
      ).toList();

      return filtered.map((sms) {
        return RawSmsMessage(
          messageBody: sms.body ?? '',
          sender: sms.address ?? 'Unknown',
          timestamp: sms.date,
        );
      }).toList();
    } catch (e) {
      throw SmsReadingException('Failed to get SMS from sender: $e');
    }
  }

  /// Filter transaction-related SMS (checking for keywords)
  List<RawSmsMessage> filterTransactionSms(List<RawSmsMessage> messages) {
    return messages.where((sms) {
      final lowerBody = sms.messageBody.toLowerCase();

      final hasTransactionKeywords =
          AppConstants.bankKeywords.any((keyword) => lowerBody.contains(keyword)) ||
          AppConstants.mpesaKeywords.any((keyword) => lowerBody.contains(keyword)) ||
          AppConstants.airtelKeywords.any((keyword) => lowerBody.contains(keyword)) ||
          AppConstants.incomeKeywords.any((keyword) => lowerBody.contains(keyword)) ||
          AppConstants.expenseKeywords.any((keyword) => lowerBody.contains(keyword));

      final amountRegex = RegExp(AppConstants.amountPattern);
      final hasAmount = amountRegex.hasMatch(lowerBody);

      return hasTransactionKeywords && hasAmount;
    }).toList();
  }
}