import 'package:permission_handler/permission_handler.dart';
import 'package:transaction_tracker/core/errors/exceptions.dart';

/// Service for handling SMS permissions
class PermissionService {
  /// Request SMS reading permission
  Future<bool> requestSmsPermission() async {
    try {
      final status = await Permission.sms.request();
      return status.isGranted;
    } catch (e) {
      throw SmsPermissionException('Failed to request SMS permission: $e');
    }
  }

  /// Check if SMS permission is granted
  Future<bool> isSmsPermissionGranted() async {
    try {
      final status = await Permission.sms.status;
      return status.isGranted;
    } catch (e) {
      throw SmsPermissionException('Failed to check SMS permission: $e');
    }
  }

  /// Open app settings to manually grant permission
  Future<bool> openAppSettings() async {
    try {
      return await openAppSettings();
    } catch (e) {
      throw SmsPermissionException('Failed to open app settings: $e');
    }
  }

  /// Check if permission is permanently denied
  Future<bool> isSmsPermissionPermanentlyDenied() async {
    try {
      final status = await Permission.sms.status;
      return status.isPermanentlyDenied;
    } catch (e) {
      throw SmsPermissionException('Failed to check permission status: $e');
    }
  }
}
