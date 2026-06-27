# SMS Transaction Analyzer

A comprehensive Flutter application that reads SMS messages from your Android device, extracts transaction-related information, stores it locally, and provides analytics dashboards for better financial tracking.

## Features

### Core Features
- 📱 **SMS Reading**: Read and analyze SMS messages with explicit user permission
- 💳 **Transaction Detection**: Automatically detect and categorize bank transfers, M-Pesa, Airtel Money, purchases, and other financial transactions
- 📊 **Analytics Dashboard**: View spending patterns with pie charts, bar charts, and line graphs
- 🔍 **Advanced Search**: Search transactions by amount, sender, date, or category
- 📂 **Smart Categorization**: Automatic categorization of transactions
- 💾 **Local Storage**: All data stored locally using SQLite via Drift
- 🔒 **Privacy First**: No cloud synchronization, complete offline functionality
- 🌙 **Dark Mode Support**: Material 3 design with dark mode

### Screens
1. **Splash Screen**: App initialization and branding
2. **Permission Screen**: Explain SMS access requirements and request permission
3. **Dashboard**: Overview of income, expenses, savings, and recent transactions
4. **Transactions**: Full transaction history with search and pagination
5. **Analytics**: Charts showing spending patterns and trends
6. **Categories**: Manage transaction categories
7. **Settings**: Configuration, data export, and privacy settings

## Project Architecture

### Clean Architecture Implementation

```
lib/
├── core/
│   ├── constants/       # App-wide constants
│   ├── errors/          # Exception definitions
│   ├── services/        # SMS parsing, reading, permission services
│   ├── theme/           # Material 3 theming
│   └── utils/           # Utility functions
├── features/
│   └── sms/
│       ├── data/
│       │   ├── datasources/     # Local database access
│       │   ├── models/          # Data models
│       │   └── repositories/    # Repository implementations
│       ├── domain/
│       │   ├── entities/        # Business entities
│       │   ├── repositories/    # Repository interfaces
│       │   └── usecases/        # Business logic
│       └── presentation/
│           ├── providers/       # Riverpod state management
│           ├── screens/         # UI screens
│           └── widgets/         # Reusable widgets
├── database/            # Drift database configuration
├── routes/              # Go Router navigation
├── injection/           # Dependency injection
└── main.dart           # App entry point
```

## State Management

The application uses **Riverpod** with the following patterns:

- **Providers**: For dependency injection and state access
- **AsyncNotifier**: For handling asynchronous operations
- **StateNotifier**: For managing UI state (search, filters)

## Database Schema

### Tables

#### SmsTransactions
- `id` (String): Primary key
- `sender` (String): Message sender
- `messageBody` (String): Full SMS text
- `amount` (Double): Transaction amount
- `transactionType` (String): Type of transaction
- `category` (String): Transaction category
- `transactionDate` (DateTime): When transaction occurred
- `balance` (Double): Account balance after transaction
- `referenceNumber` (String): Transaction reference
- `createdAt` (DateTime): When record was created

#### Categories
- `id` (Int): Primary key
- `name` (String): Category name
- `icon` (String): Icon identifier
- `color` (String): Hex color code
- `createdAt` (DateTime): Creation time

#### AnalyticsCache
- `id` (Int): Primary key
- `month` (DateTime): Month for analytics
- `totalIncome` (Double): Monthly income
- `totalExpenses` (Double): Monthly expenses
- `savings` (Double): Monthly savings
- `updatedAt` (DateTime): Last update time

## SMS Parsing Engine

The parser uses:
- **Regular Expressions**: For amount, date, reference extraction
- **Pattern Matching**: For transaction type detection
- **Keyword Analysis**: For categorization

### Supported Transaction Types
- Deposit
- Withdrawal
- Transfer
- Payment
- Purchase
- Airtime
- Loan
- Bank Transaction
- Mobile Money

### Supported Banks/Services
- Commercial banks (standard SMS format)
- M-Pesa (Safaricom)
- Airtel Money
- Generic SMS with amount patterns

## Setup Instructions

### Prerequisites
- Flutter SDK (latest stable)
- Android SDK (API level 23+)
- Dart SDK

### Installation

1. **Clone or setup the project**
```bash
cd transaction_tracker
flutter pub get
```

2. **Generate code (Drift, Freezed, Riverpod)**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. **Run the app**
```bash
flutter run
```

### Android Configuration

The app requires the following permission:
- `READ_SMS`: To read SMS messages from the device

These are requested at runtime and configured in `AndroidManifest.xml`.

## Dependencies

### Core Dependencies
- **flutter_riverpod**: State management
- **go_router**: Navigation
- **drift**: SQLite ORM
- **permission_handler**: Runtime permission handling
- **telephony_fix**: SMS reading
- **fl_chart**: Charting library

### Code Generation
- **build_runner**: Code generation runner
- **drift_dev**: Database code generation
- **freezed**: Immutable class generation
- **json_serializable**: JSON serialization
- **injectable_generator**: DI code generation
- **riverpod_generator**: Riverpod code generation

### Testing
- **flutter_test**: Testing framework
- **mocktail**: Mocking library

## Usage

### First Time Setup
1. Open the app
2. Read the permission explanation screen
3. Grant SMS access permission
4. The app will automatically scan for transactions

### Manually Rescan SMS
1. Go to Settings
2. Tap "Re-scan SMS"
3. Wait for the scan to complete

### Search Transactions
1. Go to Transactions tab
2. Use the search bar to search by:
   - Amount
   - Sender
   - Date
   - Reference code

### Export Data
1. Go to Settings
2. Tap "Export Data"
3. Choose export destination

## Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/core/services/sms_parsing_service_test.dart
```

### Generate Coverage Report
```bash
flutter test --coverage
```

### Test Coverage
- SMS Parsing Service: Regex and pattern matching
- Repository Implementation: Data persistence
- Use Cases: Business logic
- Services: SMS reading and permission handling

## Performance Optimization

- **Pagination**: Transactions loaded 20 at a time
- **Lazy Loading**: Data loaded on demand
- **Indexing**: Database queries optimized
- **Caching**: Analytics cached monthly
- **Isolates**: Heavy processing in separate threads (where needed)

## Security & Privacy

✅ **Security Features**
- All data stored locally on device
- No cloud synchronization
- No external API calls
- No analytics tracking
- No SMS content logging

✅ **Requirements**
- Explicit user consent for SMS access
- Clear privacy explanation before permission request
- Easy access to app settings for permission management

## Future Enhancements

Potential features for future versions:
1. AI-powered spending insights
2. Budget tracking and alerts
3. Recurring transaction detection
4. Bill reminders
5. Multi-currency support
6. Data backup and restore
7. Monthly reports generation
8. Financial goal tracking

## Troubleshooting

### SMS Not Being Read
- Ensure permission was granted
- Check if SMS messages exist on device
- Try "Re-scan SMS" from settings

### App Crashes on Startup
- Run `flutter clean` and `flutter pub get`
- Regenerate code: `flutter pub run build_runner build --delete-conflicting-outputs`
- Try `flutter run --debug`

### Database Issues
- Clear app data and reinstall
- Delete local database file from app storage

## Contributing

When adding new features:
1. Follow Clean Architecture principles
2. Add appropriate tests
3. Use Riverpod for state management
4. Maintain code documentation
5. Follow Flutter best practices

## License

This project is private and proprietary.

## Support

For issues or questions, please refer to the inline code documentation.
