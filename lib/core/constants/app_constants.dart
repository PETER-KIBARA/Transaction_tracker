/// Application-wide constants
class AppConstants {
  AppConstants._();

  // SMS Transaction Types
  static const String typeDeposit = 'Deposit';
  static const String typeWithdrawal = 'Withdrawal';
  static const String typeTransfer = 'Transfer';
  static const String typePayment = 'Payment';
  static const String typePurchase = 'Purchase';
  static const String typeAirtime = 'Airtime';
  static const String typeLoan = 'Loan';
  static const String typeBankTransaction = 'Bank Transaction';
  static const String typeMobileMoneyTransaction = 'Mobile Money';

  static const List<String> transactionTypes = [
    typeDeposit,
    typeWithdrawal,
    typeTransfer,
    typePayment,
    typePurchase,
    typeAirtime,
    typeLoan,
    typeBankTransaction,
    typeMobileMoneyTransaction,
  ];

  // SMS Keywords for Detection
  static const List<String> bankKeywords = [
    'bank',
    'withdraw',
    'deposit',
    'transfer',
    'atm',
  ];

  static const List<String> mpesaKeywords = [
    'mpesa',
    'm-pesa',
    'safaricom',
  ];

  static const List<String> airtelKeywords = [
    'airtel',
    'airtel money',
  ];

  static const List<String> incomeKeywords = [
    'received',
    'salary',
    'deposit',
    'credit',
    'transferred to',
    'sent',
  ];

  static const List<String> expenseKeywords = [
    'withdrawal',
    'paid',
    'purchase',
    'payment',
    'transferred from',
    'sent to',
    'bought',
    'charged',
  ];

  // Trusted financial senders
  static const List<String> trustedSenders = [
    'MPESA',
    'M-PESA',
    'Safaricom',
    'SAFARICOM',
    'AIRTEL',
    'Airtel',
    'EQUITY',
    'Equity',
    'KCB',
    'NCBA',
    'COOP',
    'ABSA',
    'STANBIC',
    'FAMILY',
    'DTB',
    'SIDIAN',
    'POSTBANK',
    'COOPERATIVE',
  ];

  // Regex patterns - Kenyan M-Pesa format specific
  static const String amountPattern =
      r'(?:Ksh|KES|ksh|kes|KSH)\s?([\d,]+(?:\.\d{1,2})?)';

  static const String balancePattern =
      r'balance is\s*(?:Ksh|KES|ksh|KSH)\s?([\d,]+(?:\.\d{1,2})?)';

  static const String datePattern =
      r'(\d{1,2}[-/]\d{1,2}[-/]\d{2,4})';

  static const String timePattern =
      r'(\d{1,2}:\d{2}\s?[APap][Mm])';

  // M-Pesa refs start with 2 letters followed by alphanumeric (e.g. UG9POAH0TK)
  static const String refPattern =
      r'^([A-Z]{2}[A-Z0-9]{8})';

  // Database
  static const String defaultCategoryName = 'Uncategorized';
  static const int pageSize = 20;
}
