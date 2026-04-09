import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static Future<void> initialize() async {
    await initializeDateFormatting('id_ID', null);
  }

  static final DateFormat _fullDateFormat = DateFormat('d MMMM yyyy', 'id_ID');
  static final DateFormat _mediumDateFormat = DateFormat('d MMM yyyy', 'id_ID');
  static final DateFormat _shortDateFormat = DateFormat('dd/MM/yyyy', 'id_ID');
  static final DateFormat _timeFormat = DateFormat('HH:mm', 'id_ID');
  static final DateFormat _fullTimeFormat = DateFormat('HH:mm:ss', 'id_ID');
  static final DateFormat _dateTimeFormat =
      DateFormat('d MMM yyyy, HH:mm', 'id_ID');
  static final DateFormat _fullDateTimeFormat =
      DateFormat('d MMMM yyyy, HH:mm', 'id_ID');
  static final DateFormat _dayNameFormat = DateFormat('EEEE', 'id_ID');
  static final DateFormat _monthYearFormat = DateFormat('MMMM yyyy', 'id_ID');

  static String formatDate(DateTime? date) {
    if (date == null) return '-';
    return _fullDateFormat.format(date);
  }

  static String formatMediumDate(DateTime? date) {
    if (date == null) return '-';
    return _mediumDateFormat.format(date);
  }

  static String formatShortDate(DateTime? date) {
    if (date == null) return '-';
    return _shortDateFormat.format(date);
  }

  static String formatTime(DateTime? date) {
    if (date == null) return '-';
    return _timeFormat.format(date);
  }

  static String formatFullTime(DateTime? date) {
    if (date == null) return '-';
    return _fullTimeFormat.format(date);
  }

  static String formatDateTime(DateTime? date) {
    if (date == null) return '-';
    return _dateTimeFormat.format(date);
  }

  static String formatFullDateTime(DateTime? date) {
    if (date == null) return '-';
    return _fullDateTimeFormat.format(date);
  }

  static String formatDayName(DateTime? date) {
    if (date == null) return '-';
    return _dayNameFormat.format(date);
  }

  static String formatMonthYear(DateTime? date) {
    if (date == null) return '-';
    return _monthYearFormat.format(date);
  }

  static String formatRelative(DateTime? date) {
    if (date == null) return '-';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes menit lalu';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours jam lalu';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days hari lalu';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks minggu lalu';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months bulan lalu';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years tahun lalu';
    }
  }

  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}j ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}d';
    } else {
      return '${seconds}d';
    }
  }

  static String formatCountdown(DateTime targetDate) {
    final now = DateTime.now();
    final difference = targetDate.difference(now);

    if (difference.isNegative) {
      return 'Waktu habis';
    }

    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    final minutes = difference.inMinutes.remainder(60);

    if (days > 0) {
      return '${days}h ${hours}j ${minutes}m';
    } else if (hours > 0) {
      return '${hours}j ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }
}
