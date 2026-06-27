import 'package:flutter_test/flutter_test.dart';
import 'package:transaction_tracker/core/services/sms_parsing_service.dart';

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
    });

    test('Parse withdrawal SMS', () {
      const messageBody = 'ATM Withdrawal: KES 2,000 on 20/5/2024 at 15:45. Balance: KES 8,000';
      const sender = 'MyBank';

      final result = smsParsingService.parseSms(messageBody, sender);

      expect(result, isNotNull);
      expect(result?.amount, 2000.00);
      expect(result?.transactionType, 'Withdrawal');
    });

    test('Parse airtime SMS', () {
      const messageBody = 'Airtime purchase: KES 100 on 21/5/2024. Balance: KES 1,500';
      const sender = 'Safaricom';

      final result = smsParsingService.parseSms(messageBody, sender);

      expect(result, isNotNull);
      expect(result?.amount, 100.00);
      expect(result?.transactionType, 'Airtime');
    });

    test('Return null for non-transaction SMS', () {
      const messageBody = 'Your appointment is confirmed for tomorrow at 10:00 AM';
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
