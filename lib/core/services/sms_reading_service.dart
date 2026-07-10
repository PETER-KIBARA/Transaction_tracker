import 'dart:io';

import 'package:flutter/services.dart';
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
  static const _pageSize = 1000;
  static const _nativeSmsChannel = MethodChannel(
    'com.example.transaction_tracker/sms_reader',
  );

  /// Get all SMS messages from device
  Future<List<RawSmsMessage>> getAllSms() async {
    try {
      if (Platform.isAndroid) {
        final records = await _nativeSmsChannel
            .invokeListMethod<Map<dynamic, dynamic>>('readAllInbox');
        return (records ?? []).map(_fromNativeRecord).toList();
      }
      return (await _queryAllInbox()).map(_fromSmsMessage).toList();
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
      final messages = await getAllSms();

      final filtered = messages.where((sms) {
        final smsDate = sms.timestamp;
        if (smsDate == null) return false;
        return smsDate.isAfter(startDate) && smsDate.isBefore(endDate);
      }).toList();

      return filtered;
    } catch (e) {
      throw SmsReadingException('Failed to filter SMS by date: $e');
    }
  }

  /// Get SMS messages from a specific sender
  Future<List<RawSmsMessage>> getSmsFromSender(String sender) async {
    try {
      final messages = await getAllSms();

      final filtered = messages
          .where(
            (sms) => sms.sender.toLowerCase().contains(sender.toLowerCase()),
          )
          .toList();

      return filtered;
    } catch (e) {
      throw SmsReadingException('Failed to get SMS from sender: $e');
    }
  }

  /// Retrieves every inbox page on platforms where the plugin is available.
  /// Filtering is intentionally deferred until all pages have been collected.
  Future<List<SmsMessage>> _queryAllInbox() async {
    final messages = <SmsMessage>[];
    var start = 0;
    while (true) {
      final page = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
        start: start,
        count: _pageSize,
      );
      messages.addAll(page);
      if (page.length < _pageSize) return messages;
      start += page.length;
    }
  }

  RawSmsMessage _fromNativeRecord(Map<dynamic, dynamic> record) {
    final timestampMillis = record['date'];
    return RawSmsMessage(
      messageBody: record['body'] as String? ?? '',
      sender: record['address'] as String? ?? 'Unknown',
      timestamp: timestampMillis is int
          ? DateTime.fromMillisecondsSinceEpoch(timestampMillis)
          : null,
    );
  }

  RawSmsMessage _fromSmsMessage(SmsMessage sms) => RawSmsMessage(
    messageBody: sms.body ?? '',
    sender: sms.address ?? 'Unknown',
    timestamp: sms.date,
  );

  /// Filter transaction-related SMS (checking for keywords)
  List<RawSmsMessage> filterTransactionSms(List<RawSmsMessage> messages) {
    return messages.where((sms) {
      final lowerBody = sms.messageBody.toLowerCase();

      final hasTransactionKeywords =
          AppConstants.bankKeywords.any(
            (keyword) => lowerBody.contains(keyword),
          ) ||
          AppConstants.mpesaKeywords.any(
            (keyword) => lowerBody.contains(keyword),
          ) ||
          AppConstants.airtelKeywords.any(
            (keyword) => lowerBody.contains(keyword),
          ) ||
          AppConstants.incomeKeywords.any(
            (keyword) => lowerBody.contains(keyword),
          ) ||
          AppConstants.expenseKeywords.any(
            (keyword) => lowerBody.contains(keyword),
          );

      final amountRegex = RegExp(AppConstants.amountPattern);
      final hasAmount = amountRegex.hasMatch(lowerBody);

      return hasTransactionKeywords && hasAmount;
    }).toList();
  }
}
