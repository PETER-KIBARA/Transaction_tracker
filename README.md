## SMS Transaction Analyzer

A personal financial tracking application built with Flutter that automatically reads SMS messages from your Android device, extracts transaction-related information, and provides analytics dashboards to help you monitor your spending.

The app is completely offline and processes all data locally on your device, ensuring total privacy.

## Features

-  **Automated SMS Parsing**: Reads SMS messages directly from your device (requires explicit user permission).
-  **Transaction Detection**: Automatically detects and categorizes various financial transactions including bank transfers, M-Pesa, Airtel Money, and purchases.
- **Analytics Dashboard**: Visualizes your spending patterns, income, and expenses over time.
-  **Advanced Search & Filtering**: Easily find specific transactions by amount, sender, date, or category.
- **100% Offline**: All data is stored locally on your device. No cloud synchronization or external servers are involved.


*Note: The app requires the `READ_SMS` permission on Android to function, which will be requested when you first open it.*

## Usage Guide

- **First Time Setup**: Open the app, read the privacy notice, and grant the required SMS access permission. The app will automatically scan for historical transactions.
- **Manually Rescan SMS**: Go to **Settings** and tap "Re-scan SMS" if you want to force an update.
- **Search Transactions**: Navigate to the **Transactions** tab to search by amount, sender, date, or reference code.
- **Export Data**: Go to **Settings** -> "Export Data" to download a complete CSV copy of your transaction history.

## Privacy & Security

Your privacy is the core focus of this application:
- **No Cloud Uploads**: Your SMS messages and financial data never leave your device.
- **No Analytics Tracking**: We do not track your app usage.
- **No External APIs**: The parsing engine works completely offline using built-in pattern matching.

## License

This project is private and proprietary.
