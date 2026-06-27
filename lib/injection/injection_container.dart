import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:transaction_tracker/core/services/permission_service.dart';
import 'package:transaction_tracker/core/services/sms_parsing_service.dart';
import 'package:transaction_tracker/core/services/sms_reading_service.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  // Core Services
  getIt.registerSingleton<PermissionService>(PermissionService());
  getIt.registerSingleton<SmsReadingService>(SmsReadingService());
  getIt.registerSingleton<SmsParsingService>(SmsParsingService());
}
