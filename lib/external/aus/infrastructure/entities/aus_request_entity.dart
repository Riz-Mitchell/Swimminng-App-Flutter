import 'package:flutter/material.dart';

@immutable
class AusResponseEntity<T> {
  final T? data;
  final bool? success;
  final int? code;

  const AusResponseEntity({
    required this.data,
    required this.success,
    required this.code,
  });

  factory AusResponseEntity.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return AusResponseEntity<T>(
      data: fromJsonT(json['data']) as T?,
      success: json['successful'] as bool?,
      code: json['code'] as int?,
    );
  }
}
