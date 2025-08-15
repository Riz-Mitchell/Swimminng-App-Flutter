import 'package:swimming_app_frontend/features/logbook/domain/models/day_log_model.dart';

class MonthLogModel {
  final int year;
  final int month;
  final Map<int, DayLogModel> days;

  MonthLogModel({required this.year, required this.month, required this.days});

  MonthLogModel copyWith({int? year, int? month, Map<int, DayLogModel>? days}) {
    return MonthLogModel(
      year: year ?? this.year,
      month: month ?? this.month,
      days: days ?? this.days,
    );
  }
}
