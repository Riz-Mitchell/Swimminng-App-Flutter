import 'package:swimming_app_frontend/features/logbook/domain/models/day_log_model.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/month_log_model.dart';

class LogbookStateModel {
  final Map<String, MonthLogModel> months;

  const LogbookStateModel({required this.months});

  LogbookStateModel copyWith({Map<String, MonthLogModel>? months}) {
    return LogbookStateModel(months: months ?? this.months);
  }

  DayLogModel? getDayData(int year, int month, int day) {
    return months['$year-$month']?.days[day];
  }
}
