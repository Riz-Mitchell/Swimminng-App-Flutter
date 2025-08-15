import 'package:flutter/material.dart';

@immutable
class AusResponseEntity<T> {
  final T data;
  final bool success;
  final int code;

  const AusResponseEntity({
    required this.data,
    required this.success,
    required this.code,
  });

  factory AusResponseEntity.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return AusResponseEntity<T>(
      data: fromJsonT(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool,
      code: json['code'] as int,
    );
  }
}
