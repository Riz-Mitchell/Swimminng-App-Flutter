import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/user_entity.dart';

@immutable
class ProfileModel {
  final GetUserEntity user;
  final List<GetSwimEntity> pbSwimsList;

  const ProfileModel({required this.user, required this.pbSwimsList});

  ProfileModel copyWith({
    GetUserEntity? user,
    List<GetSwimEntity>? pbSwimsList,
  }) {
    return ProfileModel(
      user: user ?? this.user,
      pbSwimsList: pbSwimsList ?? this.pbSwimsList,
    );
  }
}
