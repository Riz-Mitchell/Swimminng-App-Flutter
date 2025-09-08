import 'package:intl/intl.dart';
import 'package:swimming_app_frontend/features/signup/domain/enum/selected_sex_enum.dart';
import 'package:swimming_app_frontend/features/signup/domain/enum/selected_user_type_enum.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/signup_form_model.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/streak_entity.dart';

class QueryUsersEntity {
  final String nameContains;
  final int pageNumber;
  final int pageSize;

  const QueryUsersEntity({
    required this.nameContains,
    this.pageNumber = 1,
    this.pageSize = 10,
  });

  QueryUsersEntity copyWith({
    String? nameContains,
    int? pageNumber,
    int? pageSize,
  }) {
    return QueryUsersEntity(
      nameContains: nameContains ?? this.nameContains,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  Map<String, dynamic> toJson() => {
    'nameContains': nameContains,
    'pageNumber': pageNumber,
    'pageSize': pageSize,
  };
}

class GetUserEntity {
  final String id; // Dart doesn't use Guid – treat as String
  final String name;
  final int age;
  final double? height;
  final SelectedUserTypeEnum userType;
  final DateTime createdAt;
  final GetStreakEntity streak;

  GetUserEntity({
    required this.id,
    required this.name,
    required this.age,
    this.height,
    required this.userType,
    required this.createdAt,
    required this.streak,
  });

  factory GetUserEntity.fromJson(Map<String, dynamic> json) {
    return GetUserEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      height: json['height']?.toDouble(),
      userType: SelectedUserTypeEnum.values.byName(
        (json['userType'] as String).toLowerCase(),
      ),
      createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
      streak: GetStreakEntity.fromJson(json['streak'] as Map<String, dynamic>),
    );
  }

  String getMemberSince() {
    final formatter = DateFormat('MMM yyyy');
    return formatter.format(createdAt);
  }
}

class CreateUserEntity {
  final String name;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final double? height;
  final SelectedSexEnum? sex;
  final String? email;
  final SelectedUserTypeEnum userType;

  const CreateUserEntity({
    required this.name,
    required this.phoneNumber,
    required this.dateOfBirth,
    this.height,
    this.email,
    this.sex,
    required this.userType,
  });

  CreateUserEntity copyWith({
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    double? height,
    String? email,
    SelectedSexEnum? sex,
    SelectedUserTypeEnum? userType,
  }) {
    return CreateUserEntity(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      email: email ?? this.email,
      sex: sex ?? this.sex,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'phoneNumber': phoneNumber,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'height': height,
    'email': email,
    'userType': userType.name[0].toUpperCase() + userType.name.substring(1),
  };
}

class UpdateUserEntity {
  final String? name;
  final DateTime? dateOfBirth;
  final double? height;
  final String? email;

  const UpdateUserEntity({
    this.name,
    this.dateOfBirth,
    this.height,
    this.email,
  });

  UpdateUserEntity copyWith({
    String? name,
    DateTime? dateOfBirth,
    double? height,
    String? email,
  }) {
    return UpdateUserEntity(
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (dateOfBirth != null) 'dateOfBirth': dateOfBirth!.toIso8601String(),
    if (height != null) 'height': height,
    if (email != null) 'email': email,
  };
}

class UserMapper {
  static CreateUserEntity signupFormModelToEntity(SignupFormModel model) {
    return CreateUserEntity(
      name: model.name,
      phoneNumber: model.phoneNumber,
      dateOfBirth: model.dateOfBirth.toUtc(),
      height: model.height,
      email: model.email,
      userType: model.userType,
    );
  }
}
