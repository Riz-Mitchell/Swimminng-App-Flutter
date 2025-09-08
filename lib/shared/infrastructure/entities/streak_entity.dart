import 'package:flutter/material.dart';

@immutable
class GetStreakEntity {
  final int currentStreak;
  final int longestStreak;
  final DateTime lastActivityDate;

  const GetStreakEntity({
    required this.currentStreak,
    required this.longestStreak,
    required this.lastActivityDate,
  });

  factory GetStreakEntity.fromJson(Map<String, dynamic> json) {
    return GetStreakEntity(
      currentStreak: json['currentStreak'] as int,
      longestStreak: json['longestStreak'] as int,
      lastActivityDate: DateTime.parse(
        json['lastActivityDate'] as String,
      ).toLocal(),
    );
  }
}
