import 'package:intl/intl.dart';

enum TimePeriodEnum { day, week, month, threeMonths, sixMonths, year }

/// Returns a tuple of (startDate, endDate) based on selectedPeriod.
List<DateTime> getTimeRange(TimePeriodEnum period) {
  final now = DateTime.now();
  DateTime startDate;
  DateTime endDate = now;

  switch (period) {
    case TimePeriodEnum.day:
      startDate = now.subtract(Duration(days: 1));
      break;
    case TimePeriodEnum.week:
      startDate = now.subtract(Duration(days: 7));
      break;
    case TimePeriodEnum.month:
      startDate = DateTime(now.year, now.month - 1, now.day);
      break;
    case TimePeriodEnum.threeMonths:
      startDate = DateTime(now.year, now.month - 3, now.day);
      break;
    case TimePeriodEnum.sixMonths:
      startDate = DateTime(now.year, now.month - 6, now.day);
      break;
    case TimePeriodEnum.year:
      startDate = DateTime(now.year - 1, now.month, now.day);
      break;
  }

  return [startDate, endDate];
}

String formatDate(DateTime date) {
  return DateFormat('d MMM').format(date); // Example: 10 Jul
}

class DateLabelConverter {
  static String format(DateTime date, TimePeriodEnum timePeriod) {
    switch (timePeriod) {
      case TimePeriodEnum.day:
        final now = DateTime.now();
        final isYesterday =
            date.day == now.subtract(Duration(days: 1)).day &&
            date.month == now.month &&
            date.year == now.year;
        final timeString = DateFormat('h:mma').format(date);
        return isYesterday ? 'Yesterday, $timeString' : timeString;
      case TimePeriodEnum.week:
        // Example: Monday, Tuesday
        return DateFormat('h:mma EEE').format(date);
      case TimePeriodEnum.month:
        // Example: 11 June
        return DateFormat('d MMMM').format(date);
      case TimePeriodEnum.threeMonths:
      case TimePeriodEnum.sixMonths:
      case TimePeriodEnum.year:
        // Example: June 2025
        return DateFormat('MMMM yyyy').format(date);
    }
  }
}
