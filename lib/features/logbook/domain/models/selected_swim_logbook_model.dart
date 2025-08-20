import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';

@immutable
class SelectedSwimLogbookModel {
  final int index;
  final GetSwimEntity swimRef;

  const SelectedSwimLogbookModel({required this.index, required this.swimRef});

  SelectedSwimLogbookModel copyWith({int? index, GetSwimEntity? swimRef}) {
    return SelectedSwimLogbookModel(
      index: index ?? this.index,
      swimRef: swimRef ?? this.swimRef,
    );
  }
}
