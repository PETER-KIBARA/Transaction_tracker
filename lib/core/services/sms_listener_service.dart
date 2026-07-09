import 'dart:async';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:transaction_tracker/core/errors/exceptions.dart';
import 'package:transaction_tracker/core/services/sms_parsing_service.dart';
import 'package:transaction_tracker/core/services/sms_reading_service.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';
import 'package:transaction_tracker/features/sms/domain/repositories/sms_transaction_repository.dart';

/// Service for listening to incoming SMS messages in real-time
/// Uses periodic polling since flutter_sms_inbox doesn't support streaming
class SmsListenerService {
  final SmsParsingService _parsingService;
  final SmsTransactionRepository _repository;
  final SmsReadingService _readingService;
  final SmsQuery _query = SmsQuery();
  Timer? _pollingTimer;
  DateTime? _lastCheckTime;
  static const pollingInterval = Duration(seconds: 30);

  SmsListenerService({
    required SmsParsingService parsingService,
    required SmsTransactionRepository repository,
    required SmsReadingService readingService,
  })  : _parsingService = parsingService,
        _repository = repository,
        _readingService = readingService;

  /// Start listening for incoming SMS messages
  Future<void> startListening() async {
    try {
      if (_pollingTimer != null) {
        return; // Already listening
      }

      // Set initial check time to now
      _lastCheckTime = DateTime.now();

      // Start periodic polling for new SMS
      _pollingTimer = Timer.periodic(pollingInterval, (_) {
        _checkForNewSms();
      });
    } catch (e) {
      throw SmsReadingException('Failed to start SMS listener: $e');
    }
  }

  /// Stop listening for incoming SMS messages
  void stopListening() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  /// Check for new SMS messages since last check
  Future<void> _checkForNewSms() async {
    try {
      if (_lastCheckTime == null) return;

      final allSms = await _readingService.getAllSms();
      final newSms = allSms.where((sms) {
        final timestamp = sms.timestamp;
        return timestamp != null && timestamp.isAfter(_lastCheckTime!);
      }).toList();

      if (newSms.isNotEmpty) {
        await _processIncomingSms(newSms);
      }

      // Update last check time
      _lastCheckTime = DateTime.now();
    } catch (e) {
      throw SmsReadingException('Failed to check for new SMS: $e');
    }
  }

  /// Process incoming SMS messages
  Future<void> _processIncomingSms(List<RawSmsMessage> smsList) async {
    try {
      final transactions = <SmsTransactionEntity>[];

      for (final sms in smsList) {
        // Parse the SMS message
        final transaction = _parsingService.parseSms(sms.messageBody, sms.sender);
        
        if (transaction != null) {
          transactions.add(transaction);
        }
      }

      // Save valid transactions to database
      if (transactions.isNotEmpty) {
        await _repository.addMultipleTransactions(transactions);
      }
    } catch (e) {
      throw SmsReadingException('Failed to process incoming SMS: $e');
    }
  }

  /// Check if currently listening
  bool get isListening => _pollingTimer != null;
}
