import 'package:transaction_tracker/core/constants/app_constants.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';
import 'package:intl/intl.dart';

/// Service for parsing SMS messages to extract transaction information
class SmsParsingService {
  /// Parse SMS message and extract transaction details
  SmsTransactionEntity? parseSms(String messageBody, String sender) {
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

      // Extract date (or use current date)
      final dateTime = _extractDate(messageBody) ?? DateTime.now();

      // Extract reference number
      final reference = _extractReference(messageBody);

      // Extract balance if present
      final balance = _extractBalance(messageBody);

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
        balance: balance,
        referenceNumber: reference,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      return null; // skip bad messages silently
    }
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
        lowerMessage.contains('balance')) {
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
      final dateRegex = RegExp(AppConstants.datePattern);
      final match = dateRegex.firstMatch(message);

      if (match != null) {
        final dateStr = match.group(0) ?? '';
        return _parseDate(dateStr);
      }
    } catch (e) {
      // Return null if date parsing fails
    }
    return null;
  }

  /// Parse date string in various formats
  DateTime? _parseDate(String dateStr) {
    final formats = [
      'dd/MM/yyyy',
      'dd-MM-yyyy',
      'yyyy/MM/dd',
      'yyyy-MM-dd',
      'MM/dd/yyyy',
      'MM-dd-yyyy',
      'dd/MM/yy',
      'dd-MM-yy',
      'd/M/yy',
      'd/M/yyyy',
    ];

    for (final format in formats) {
      try {
        final parsed = DateFormat(format).parse(dateStr);
        // Fix 2-digit year parsing (0026 → 2026)
        if (parsed.year < 100) {
          return DateTime(
            parsed.year + 2000,
            parsed.month,
            parsed.day,
          );
        }
        return parsed;
      } catch (e) {
        continue;
      }
    }
    return null;
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