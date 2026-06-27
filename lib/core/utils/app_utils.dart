import 'package:intl/intl.dart';

/// Utility functions for formatting and conversions
class AppUtils {
  AppUtils._();

  /// Format currency amount
  static String formatCurrency(double amount, [String symbol = 'KES']) {
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: 2);
    return formatter.format(amount);
  }

  /// Format simple currency (without symbol)
  static String formatSimpleCurrency(double amount) {
    return amount.toStringAsFixed(2);
  }

  /// Format date to readable string
  static String formatDate(DateTime date, [String format = 'dd MMM yyyy']) {
    return DateFormat(format).format(date);
  }

  /// Format date and time
  static String formatDateTime(DateTime dateTime, [String format = 'dd MMM yyyy HH:mm']) {
    return DateFormat(format).format(dateTime);
  }

  /// Format time only
  static String formatTime(DateTime dateTime, [String format = 'HH:mm']) {
    return DateFormat(format).format(dateTime);
  }

  /// Get time ago (e.g., "2 days ago")
  static String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks weeks ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months months ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years years ago';
    }
  }

  /// Check if date is today
  static bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime dateTime) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day;
  }

  /// Get month name
  static String getMonthName(int month) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  /// Get day name
  static String getDayName(int day) {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[day - 1];
  }
}
