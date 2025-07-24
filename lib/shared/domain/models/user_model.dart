enum UserType {
  swimmer,
  coach,
  admin, // Add more as needed
}

enum Sex { male, female }

class GetUsersQuery {
  final String nameContains;
  final int pageNumber;
  final int pageSize;

  const GetUsersQuery({
    required this.nameContains,
    this.pageNumber = 1,
    this.pageSize = 10,
  });

  GetUsersQuery copyWith({
    String? nameContains,
    int? pageNumber,
    int? pageSize,
  }) {
    return GetUsersQuery(
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

class GetUserResDTO {
  final String id; // Dart doesn't use Guid – treat as String
  final String name;
  final int age;
  final double? height;
  final UserType userType;

  GetUserResDTO({
    required this.id,
    required this.name,
    required this.age,
    this.height,
    required this.userType,
  });

  factory GetUserResDTO.fromJson(Map<String, dynamic> json) {
    return GetUserResDTO(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      height: json['height']?.toDouble(),
      userType: UserType.values.byName(
        (json['userType'] as String).toLowerCase(),
      ),
    );
  }
}

class CreateUserReqDTO {
  final String name;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final double? height;
  final Sex? sex;
  final String? email;
  final UserType userType;

  const CreateUserReqDTO({
    required this.name,
    required this.phoneNumber,
    required this.dateOfBirth,
    this.height,
    this.email,
    this.sex,
    required this.userType,
  });

  CreateUserReqDTO copyWith({
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    double? height,
    String? email,
    Sex? sex,
    UserType? userType,
  }) {
    return CreateUserReqDTO(
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

class UpdateUserReqDTO {
  final String? name;
  final DateTime? dateOfBirth;
  final double? height;
  final String? email;

  const UpdateUserReqDTO({
    this.name,
    this.dateOfBirth,
    this.height,
    this.email,
  });

  UpdateUserReqDTO copyWith({
    String? name,
    DateTime? dateOfBirth,
    double? height,
    String? email,
  }) {
    return UpdateUserReqDTO(
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
