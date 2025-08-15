import 'package:flutter/material.dart';

@immutable
class AusRequestEntity<T> {
  final T data;
  final bool success;
  final int code;

  const AusRequestEntity({
    required this.data,
    required this.success,
    required this.code,
  });

  factory AusRequestEntity.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return AusRequestEntity<T>(
      data: fromJsonT(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool,
      code: json['code'] as int,
    );
  }
}
