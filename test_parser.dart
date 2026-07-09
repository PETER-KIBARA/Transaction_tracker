import 'package:transaction_tracker/core/services/sms_parsing_service.dart';

void main() {
  final service = SmsParsingService();
  
  // Test case 1: M-Pesa received (Bug 2 related)
  final t1 = service.parseSms("You have received Ksh 1,500.00 from Jane Doe. New M-PESA balance is Ksh 5,000.00.", "MPESA");
  print("1. Received: ${t1?.amount} - ${t1?.transactionType}");
  
  // Test case 2: M-Pesa sent (Bug 2 related)
  final t2 = service.parseSms("Ksh10.00 sent to John Doe 0712345678 on 12/03/26 at 10:00 AM. New M-PESA balance is Ksh100.00. Transaction cost, Ksh0.00. Amount you can transact within the day is 299,900.00.", "MPESA");
  print("2. Sent: ${t2?.amount} - ${t2?.transactionType}");
}
