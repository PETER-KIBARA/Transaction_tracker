import 'package:flutter_test/flutter_test.dart';
import 'package:transaction_tracker/core/services/sms_parsing_service.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';

void main() {
  late SmsParsingService smsParsingService;

  setUp(() {
    smsParsingService = SmsParsingService();
  });

  group('SMS Parsing Service', () {
    test('Parse bank transfer SMS', () {
      const messageBody =
          'You have transferred KES 1,000.00 to John Doe. Ref: TXN123456. Balance: KES 5,000.00';
      const sender = 'Bank';

      final result = smsParsingService.parseSms(messageBody, sender);

      expect(result, isNotNull);
      expect(result?.amount, 1000.00);
      expect(result?.transactionType, 'Transfer');
      expect(result?.referenceNumber, 'TXN123456');
      expect(result?.balance, 5000.00);
    });

    test('Parse M-Pesa SMS', () {
      const messageBody =
          'You have received KSH 500 from 0712345678 on 19/5/2024 at 14:30. New M-Pesa balance is KSH 2,500.00';
      const sender = 'MPESA';

      final result = smsParsingService.parseSms(messageBody, sender);

      expect(result, isNotNull);
      expect(result?.amount, 500.00);
      expect(result?.transactionType, 'Mobile Money');
      expect(result?.provider, TransactionProvider.mpesa);
    });

    test('identifies Airtel and Equity providers from sender or SMS body', () {
      expect(
        detectTransactionProvider(sender: 'AIRTELMONEY'),
        TransactionProvider.airtel,
      );
      expect(
        detectTransactionProvider(
          sender: 'service',
          messageBody: 'Your Equity Bank account has been credited',
        ),
        TransactionProvider.equity,
      );
    });

    test('uses unknown for trusted providers without a dashboard mapping', () {
      expect(
        detectTransactionProvider(sender: 'KCB'),
        TransactionProvider.unknown,
      );
    });

    test('parses Equity day-first date and 24-hour time', () {
      const messageBody =
          'Confirmed, Bill payment to GATHERA SHOP of KES. 60.00 for account 927417 and Ref. UG2PO9NLQ8 on 02-07-2026 at 09:26.Thank you.';

      final result = smsParsingService.parseSms(messageBody, 'Equity');

      expect(result, isNotNull);
      expect(result?.transactionDate, DateTime(2026, 7, 2, 9, 26));
    });

    test('parses Airtel day-first date, two-digit year, and AM time', () {
      const messageBody =
          'TID:O3OJ9IP74RG. Received Ksh 20 from Peter Kibara Muriuki 254740674291 on 08/07/26 11:24 AM. Bal:Ksh 20.0 Sender TID:UG8POACU00.';

      final result = smsParsingService.parseSms(messageBody, 'AIRTEL');

      expect(result, isNotNull);
      expect(result?.transactionDate, DateTime(2026, 7, 8, 11, 24));
    });

    test('parses M-Pesa unpadded day-first date and PM time', () {
      const messageBody =
          'UGAPOALDGV Confirmed. Ksh60.00 sent to STANLEY  GATHUMBI 0115515360 on 10/7/26 at 12:17 PM. New M-PESA balance is Ksh152.12. Transaction cost, Ksh0.00.  Amount you can transact within the day is 499,940.00. Download My OneApp on https://saf.cx/lPKcC';

      final result = smsParsingService.parseSms(messageBody, 'MPESA');

      expect(result, isNotNull);
      expect(result?.transactionDate, DateTime(2026, 7, 10, 12, 17));
    });

    test('uses the SMS receipt timestamp instead of a Fuliza due date', () {
      const messageBody =
          'UG7POAAUDK Confirmed. Fuliza M-PESA amount is Ksh 20.00. Access Fee charged Ksh 0.20. Total Fuliza M-PESA outstanding amount is Ksh90.88 due on 01/08/26. To check daily charges, Dial *334#OK Select Query Charges';
      final receivedAt = DateTime(2026, 7, 7, 18, 58, 48);

      final result = smsParsingService.parseSms(
        messageBody,
        'MPESA',
        receivedAt: receivedAt,
      );

      expect(result, isNotNull);
      expect(result?.transactionDate, receivedAt);
      expect(result?.transactionDate, isNot(DateTime(2026, 8, 1)));

      final fallbackResult = smsParsingService.parseSms(messageBody, 'MPESA');
      expect(fallbackResult?.transactionDate, isNot(DateTime(2026, 8, 1)));
    });

    test('Parse withdrawal SMS', () {
      const messageBody =
          'ATM Withdrawal: KES 2,000 on 20/5/2024 at 15:45. Balance: KES 8,000';
      const sender = 'MyBank';

      final result = smsParsingService.parseSms(messageBody, sender);

      expect(result, isNotNull);
      expect(result?.amount, 2000.00);
      expect(result?.transactionType, 'Withdrawal');
    });

    test('Parse airtime SMS', () {
      const messageBody =
          'Airtime purchase: KES 100 on 21/5/2024. Balance: KES 1,500';
      const sender = 'Safaricom';

      final result = smsParsingService.parseSms(messageBody, sender);

      expect(result, isNotNull);
      expect(result?.amount, 100.00);
      expect(result?.transactionType, 'Airtime');
    });

    test('Return null for non-transaction SMS', () {
      const messageBody =
          'Your appointment is confirmed for tomorrow at 10:00 AM';
      const sender = 'Hospital';

      final result = smsParsingService.parseSms(messageBody, sender);

      expect(result, isNull);
    });

    test('Extract category correctly', () {
      const messageBody1 = 'Food purchase: KES 500 at restaurant on 22/5/2024';
      const messageBody2 = 'Fuel purchase: KES 3,000 at Shell station';
      const messageBody3 = 'Email bill paid: KES 499 on 23/5/2024';

      final result1 = smsParsingService.parseSms(messageBody1, 'Visa');
      final result2 = smsParsingService.parseSms(messageBody2, 'Visa');
      final result3 = smsParsingService.parseSms(messageBody3, 'MyBank');

      expect(result1?.category.toLowerCase(), contains('food'));
      expect(result2?.category, 'Fuel');
      expect(result3?.category, 'Bills');
    });
  });
}
