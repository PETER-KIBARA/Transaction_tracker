# Setup Instructions for SMS Transaction Analyzer

This guide will help you set up and run the SMS Transaction Analyzer application.

## Prerequisites

- **Flutter SDK**: Latest stable version (3.11.0 or higher)
- **Android SDK**: API level 23 or higher
- **Java Development Kit (JDK)**: Version 11 or higher
- **Dart SDK**: Included with Flutter
- **Git**: For version control

## Step 1: Initial Setup

### 1.1 Install Flutter

If you haven't already installed Flutter, follow the official documentation:
https://flutter.dev/docs/get-started/install

### 1.2 Verify Installation

```bash
flutter doctor
```

This command checks your environment and displays a report. Ensure all required dependencies are installed.

## Step 2: Clone/Open Project

```bash
cd /path/to/transaction_tracker
```

## Step 3: Get Dependencies

```bash
flutter pub get
```

This installs all the dependencies specified in `pubspec.yaml`.

## Step 4: Code Generation

The project uses several code generation libraries. You need to run build_runner to generate the necessary files.

### 4.1 Generate All Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This command generates:
- **Drift database code** (app_database.g.dart)
- **Freezed immutable classes** (*.freezed.dart)
- **JSON serialization code** (*.g.dart)
- **Riverpod providers** (sms_providers.g.dart)
- **Injectable DI code** (injection_container.g.dart)

> **Note**: If you make changes to any entity, model, or provider, run this command again.

### 4.2 Watch Mode (Optional)

For development, you can use watch mode to automatically regenerate code on changes:

```bash
flutter pub run build_runner watch
```

Press `q` to stop the watch process.

## Step 5: Create Android Debug Keystore

For SMS permission testing, you may need a debug keystore:

```bash
keytool -genkey -v -keystore ~/.android/debug.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias androiddebugkey -keypass android -storepass android
```

## Step 6: Run the Application

### 6.1 On Android Device/Emulator

First, ensure you have an Android device or emulator running:

```bash
flutter run
```

For running on a specific device:

```bash
flutter run -d <device_id>
```

To see available devices:

```bash
flutter devices
```

### 6.2 Release Build

```bash
flutter run --release
```

## Step 7: Verify Installation

1. The app should launch and show the splash screen
2. You'll be directed to the permission screen
3. Grant SMS access permission
4. The app will scan your device for SMS messages
5. Transactions will appear on the Dashboard

## Common Issues and Solutions

### Issue 1: Build Runner Errors

**Error**: `Failed to build the Dart application.`

**Solution**:
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue 2: Gradle Build Errors

**Error**: `Could not resolve dependency...`

**Solution**:
```bash
cd android
./gradlew clean
cd ..
flutter pub get
```

### Issue 3: Drift Database Errors

**Error**: `Error: Cannot find a generator for...`

**Solution**:
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue 4: Permission Denied

The app requires SMS reading permission. If denied:
1. Go to Settings > Apps > SMS Transaction Analyzer > Permissions
2. Enable "SMS" permission
3. Restart the app

### Issue 5: No SMS Messages Found

**Check if:**
- SMS messages actually exist on your device
- You're using a real device (emulator may not have SMS)
- Permission was granted successfully
- Try "Re-scan SMS" from the Settings tab

## Development Workflow

### Making Changes

1. **Code Changes**: Simply hot reload or hot restart
   - Hot reload: `r` in terminal
   - Hot restart: `R` in terminal

2. **Data Model Changes**: Run build_runner
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Database Schema Changes**: 
   - Modify `lib/database/database_tables.dart`
   - Update `@DriftDatabase` in `app_database.dart`
   - Run build_runner

4. **New Entity/Model**: 
   - Create the file with `@freezed` annotation
   - Add `part` directives
   - Run build_runner

### Running Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/core/services/sms_parsing_service_test.dart

# With coverage
flutter test --coverage
```

### Code Generation Issues

If you encounter generated file issues:

1. Clean everything:
```bash
flutter clean
rm -rf pubspec.lock
```

2. Reinstall:
```bash
flutter pub get
```

3. Regenerate:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Building for Release

### Creating a Release APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Creating an App Bundle

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

## Code Structure Quick Reference

| Layer | Location | Purpose |
|-------|----------|---------|
| Entities | `lib/features/sms/domain/entities/` | Business logic models |
| Repositories (Interface) | `lib/features/sms/domain/repositories/` | Contract definitions |
| Use Cases | `lib/features/sms/domain/usecases/` | Business logic operations |
| Models | `lib/features/sms/data/models/` | Data transfer objects |
| Data Sources | `lib/features/sms/data/datasources/` | Database access |
| Repositories (Impl) | `lib/features/sms/data/repositories/` | Repository implementation |
| Providers | `lib/features/sms/presentation/providers/` | State management |
| Screens | `lib/features/sms/presentation/screens/` | UI screens |
| Widgets | `lib/features/sms/presentation/widgets/` | Reusable components |

## Useful Commands

| Command | Description |
|---------|-------------|
| `flutter pub get` | Get dependencies |
| `flutter pub upgrade` | Upgrade dependencies |
| `flutter pub outdated` | Check for outdated packages |
| `flutter analyze` | Run linter |
| `flutter format .` | Format all code |
| `flutter doctor -v` | Verbose environment info |
| `flutter clean` | Clean build cache |
| `flutter devices` | List connected devices |

## Environment Variables

No special environment variables are required for development. The app stores all data locally in SQLite.

## Troubleshooting Guide

### Build Issues
- Run `flutter clean` and `flutter pub get`
- Delete `pubspec.lock` if dependency conflicts occur
- Update Flutter: `flutter upgrade`

### Runtime Issues
- Check logcat: `flutter logs`
- Verify permissions in AndroidManifest.xml
- Check SQLite database: `adb shell`

### Performance Issues
- Use `flutter run --profile` for profiling
- Check widget rebuild frequency with DevTools

## Next Steps

1. Read the [README.md](README.md) for feature documentation
2. Explore the code structure in `lib/`
3. Check test files for usage examples
4. Review inline code comments for implementation details

## Support

For issues or questions:
1. Check this SETUP_INSTRUCTIONS.md
2. Review README.md
3. Check inline code comments
4. Examine test files for examples

Good luck with SMS Transaction Analyzer! 🚀
