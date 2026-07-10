import 'package:transaction_tracker/core/constants/app_constants.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';

/// Service for parsing SMS messages to extract transaction information
class SmsParsingService {
  /// Parse SMS message and extract transaction details
  SmsTransactionEntity? parseSms(
    String messageBody,
    String sender, {
    DateTime? receivedAt,
  }) {
    try {
      if (messageBody.isEmpty) return null;

      // Only process SMS from known financial senders
      final isFinancialSender = AppConstants.trustedSenders.any(
        (s) => sender.toUpperCase().contains(s.toUpperCase()),
      );
      if (!isFinancialSender) return null;

      // Determine transaction type
      final transactionType = _determineTransactionType(messageBody);
      if (transactionType == null) return null;

      // Extract amount - must be non-zero
      final amount = _extractAmount(messageBody);
      if (amount == null || amount <= 0) return null;

      // The inbox timestamp is the authoritative receipt time. Text dates can
      // refer to a repayment due date or other non-transaction event.
      final dateTime =
          receivedAt ?? _extractDate(messageBody) ?? DateTime.now();

      // Extract reference number
      final reference = _extractReference(messageBody);

      // Extract balance if present
      final balance = _extractBalance(messageBody);
      final provider = detectTransactionProvider(
        sender: sender,
        messageBody: messageBody,
      );
      final transactionCost = _extractTransactionCost(messageBody);

      // Determine category based on keywords
      final category = _determineCategory(messageBody, transactionType);

      return SmsTransactionEntity(
        id: '${sender}_${dateTime.millisecondsSinceEpoch}',
        sender: sender,
        messageBody: messageBody,
        amount: amount,
        transactionType: transactionType,
        category: category,
        transactionDate: dateTime,
        provider: provider,
        transactionCost: transactionCost,
        balance: balance,
        referenceNumber: reference,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      return null; // skip bad messages silently
    }
  }

  double? _extractTransactionCost(String message) {
    final match = RegExp(
      r'(?:transaction cost|pay bill charge|transaction fee|charge)\s*[,.:]?\s*(?:Ksh|KES)\.?\s*([\d,]+(?:\.\d{1,2})?)',
      caseSensitive: false,
    ).firstMatch(message);
    return double.tryParse((match?.group(1) ?? '').replaceAll(',', ''));
  }

  /// Determine if message is a transaction-related SMS
  String? _determineTransactionType(String message) {
    final lowerMessage = message.toLowerCase();

    // Check for transfer/sent
    if (lowerMessage.contains('transfer') ||
        lowerMessage.contains('sent to') ||
        lowerMessage.contains('transferred to')) {
      return AppConstants.typeTransfer;
    }

    // Check for withdrawal
    if (lowerMessage.contains('withdraw') ||
        lowerMessage.contains('withdrawal')) {
      return AppConstants.typeWithdrawal;
    }

    // Check for deposit/received
    if (lowerMessage.contains('deposit') ||
        lowerMessage.contains('deposited') ||
        lowerMessage.contains('credited') ||
        lowerMessage.contains('you have received')) {
      return AppConstants.typeDeposit;
    }

    // Check for payment
    if (lowerMessage.contains('payment') || lowerMessage.contains('paid')) {
      return AppConstants.typePayment;
    }

    // Check for purchase
    if (lowerMessage.contains('purchase') || lowerMessage.contains('bought')) {
      return AppConstants.typePurchase;
    }

    // Check for airtime
    if (lowerMessage.contains('airtime') ||
        lowerMessage.contains('mobile credit') ||
        lowerMessage.contains('air time')) {
      return AppConstants.typeAirtime;
    }

    // Check for loan
    if (lowerMessage.contains('loan') || lowerMessage.contains('borrowed')) {
      return AppConstants.typeLoan;
    }

    // Check for Mobile Money (M-Pesa, Airtel Money)
    if (lowerMessage.contains('mpesa') ||
        lowerMessage.contains('m-pesa') ||
        lowerMessage.contains('airtel money')) {
      return AppConstants.typeMobileMoneyTransaction;
    }

    // Check for bank transactions
    if (lowerMessage.contains('bank') || lowerMessage.contains('account')) {
      return AppConstants.typeBankTransaction;
    }

    // Generic transaction keywords
    if (lowerMessage.contains('received') ||
        lowerMessage.contains('deposited') ||
        lowerMessage.contains('credit')) {
      return AppConstants.typeDeposit;
    }

    return null;
  }

  /// Extract first non-zero amount from message
  double? _extractAmount(String message) {
    final amountRegex = RegExp(
      AppConstants.amountPattern,
      caseSensitive: false,
    );

    // Get all matches and return the FIRST non-zero amount
    // Transaction cost Ksh0.00 appears later in M-Pesa messages
    final matches = amountRegex.allMatches(message);
    for (final match in matches) {
      final amountStr = match.group(1)?.replaceAll(',', '') ?? '';
      final amount = double.tryParse(amountStr);
      if (amount != null && amount > 0) {
        return amount;
      }
    }
    return null;
  }

  /// Extract date from message
  DateTime? _extractDate(String message) {
    try {
      final dateRegex = RegExp(AppConstants.dateTimePattern);
      for (final match in dateRegex.allMatches(message)) {
        if (_isNonTransactionDate(message, match)) continue;
        return _parseDateTime(match);
      }
    } catch (e) {
      // Return null if date parsing fails
    }
    return null;
  }

  /// Ignores dates that describe a loan due date, validity period, or balance
  /// status rather than the transaction confirmation itself.
  bool _isNonTransactionDate(String message, RegExpMatch match) {
    final precedingText = message
        .substring(0, match.start)
        .toLowerCase()
        .replaceFirst(RegExp(r'\s+$'), '');
    return RegExp(
      r'(?:due|outstanding|expiry|valid\s+until)$',
    ).hasMatch(precedingText);
  }

  /// Parses the day-first date and optional time captured from a Kenyan SMS.
  DateTime? _parseDateTime(RegExpMatch match) {
    final day = int.tryParse(match.group(1) ?? '');
    final month = int.tryParse(match.group(3) ?? '');
    final rawYear = int.tryParse(match.group(4) ?? '');
    if (day == null || month == null || rawYear == null) return null;

    // Kenyan provider messages use 20xx dates in the app's realistic range.
    // Keep this normalization in one shared path for every provider.
    final year = rawYear < 100 ? 2000 + rawYear : rawYear;

    var hour = int.tryParse(match.group(5) ?? '') ?? 0;
    final minute = int.tryParse(match.group(6) ?? '') ?? 0;
    final meridiem = match.group(7)?.toUpperCase();

    if (minute > 59 || hour < 0) return null;
    if (meridiem != null) {
      if (hour < 1 || hour > 12) return null;
      if (meridiem == 'PM' && hour != 12) hour += 12;
      if (meridiem == 'AM' && hour == 12) hour = 0;
    } else if (hour > 23) {
      return null;
    }

    final result = DateTime(year, month, day, hour, minute);
    // DateTime normalizes invalid components (for example, 31 February), so
    // verify that the captured values represent a real calendar date.
    if (result.year != year || result.month != month || result.day != day) {
      return null;
    }
    return result;
  }

  /// Extract reference number from start of M-Pesa message
  String? _extractReference(String message) {
    // M-Pesa refs appear at the very start e.g. "UG9POAH0TK Confirmed."
    final refRegex = RegExp(AppConstants.refPattern, caseSensitive: false);
    final match = refRegex.firstMatch(message.trim());
    return match?.group(1);
  }

  /// Extract balance from message
  double? _extractBalance(String message) {
    final balanceRegex = RegExp(
      AppConstants.balancePattern,
      caseSensitive: false,
    );
    final match = balanceRegex.firstMatch(message);

    if (match != null) {
      final balanceStr = match.group(1)?.replaceAll(',', '') ?? '';
      return double.tryParse(balanceStr);
    }
    return null;
  }

  /// Determine category based on transaction details
  String _determineCategory(String message, String transactionType) {
    final lowerMessage = message.toLowerCase();

    switch (transactionType) {
      case 'Transfer':
        return 'Transfer';
      case 'Withdrawal':
        return 'Cash Withdrawal';
      case 'Payment':
        if (lowerMessage.contains('bill')) return 'Bills';
        if (lowerMessage.contains('utility')) return 'Utilities';
        if (lowerMessage.contains('school') ||
            lowerMessage.contains('education')) {
          return 'Education';
        }
        return 'Payment';
      case 'Purchase':
        if (lowerMessage.contains('food') ||
            lowerMessage.contains('restaurant')) {
          return 'Food & Dining';
        }
        if (lowerMessage.contains('grocery') ||
            lowerMessage.contains('supermarket')) {
          return 'Groceries';
        }
        if (lowerMessage.contains('fuel')) return 'Fuel';
        if (lowerMessage.contains('shopping')) return 'Shopping';
        return 'Purchase';
      case 'Airtime':
        return 'Airtime & Credit';
      case 'Mobile Money':
        return 'Mobile Money';
      case 'Deposit':
        if (lowerMessage.contains('salary') ||
            lowerMessage.contains('payroll')) {
          return 'Salary';
        }
        return 'Deposit';
      case 'Loan':
        return 'Loan';
      case 'Bank Transaction':
        return 'Banking';
      default:
        return 'Other';
    }
  }
}
