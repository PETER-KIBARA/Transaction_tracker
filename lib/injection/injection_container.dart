import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:transaction_tracker/core/services/permission_service.dart';
import 'package:transaction_tracker/core/services/sms_parsing_service.dart';
import 'package:transaction_tracker/core/services/sms_reading_service.dart';
import 'package:transaction_tracker/core/services/sms_listener_service.dart';
import 'package:transaction_tracker/features/sms/data/repositories/sms_transaction_repository_impl.dart';
import 'package:transaction_tracker/features/sms/domain/repositories/sms_transaction_repository.dart';
import 'package:transaction_tracker/features/sms/data/datasources/local_sms_datasource.dart';
import 'package:transaction_tracker/database/app_database.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  // Database
  getIt.registerSingleton<AppDatabase>(AppDatabase());

  // Data Source
  getIt.registerLazySingleton<LocalSmsDataSource>(
    () => LocalSmsDataSourceImpl(getIt<AppDatabase>()),
  );

  // Repository
  getIt.registerLazySingleton<SmsTransactionRepository>(
    () => SmsTransactionRepositoryImpl(getIt<LocalSmsDataSource>()),
  );

  // Core Services
  getIt.registerSingleton<PermissionService>(PermissionService());
  getIt.registerSingleton<SmsReadingService>(SmsReadingService());
  getIt.registerSingleton<SmsParsingService>(SmsParsingService());

  // SMS Listener Service
  getIt.registerSingleton<SmsListenerService>(
    SmsListenerService(
      parsingService: getIt<SmsParsingService>(),
      repository: getIt<SmsTransactionRepository>(),
      readingService: getIt<SmsReadingService>(),
    ),
  );
}
