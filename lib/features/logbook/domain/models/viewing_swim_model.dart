import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/split_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';

@immutable
class ViewingSwimModel {
  final GetSwimEntity? swim;
  final GetSplitEntity? selectedSplit;

  const ViewingSwimModel({this.swim, this.selectedSplit});

  ViewingSwimModel copyWith({
    GetSwimEntity? swim,
    GetSplitEntity? selectedSplit,
  }) {
    return ViewingSwimModel(
      swim: swim ?? this.swim,
      selectedSplit: selectedSplit ?? this.selectedSplit,
    );
  }
}
