enum UserType {
  swimmer,
  coach,
  admin, // Add more as needed
}

class GetUsersQuery {
  final String nameContains;
  final int pageNumber;
  final int pageSize;

  GetUsersQuery({
    required this.nameContains,
    this.pageNumber = 1,
    this.pageSize = 10,
  });

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
      id: json['Id'] as String,
      name: json['Name'] as String,
      age: json['Age'] as int,
      height: json['Height']?.toDouble(),
      userType: UserType.values.byName(json['UserType']),
    );
  }
}

class CreateUserReqDTO {
  final String name;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final double? height;
  final String? email;
  final UserType userType;

  CreateUserReqDTO({
    required this.name,
    required this.phoneNumber,
    required this.dateOfBirth,
    this.height,
    this.email,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
    'Name': name,
    'PhoneNumber': phoneNumber,
    'DateOfBirth': dateOfBirth.toIso8601String(),
    'Height': height,
    'Email': email,
    'UserType': userType.name,
  };
}

class UpdateUserReqDTO {
  final String? name;
  final DateTime? dateOfBirth;
  final double? height;
  final String? email;

  UpdateUserReqDTO({this.name, this.dateOfBirth, this.height, this.email});

  Map<String, dynamic> toJson() => {
    if (name != null) 'Name': name,
    if (dateOfBirth != null) 'DateOfBirth': dateOfBirth!.toIso8601String(),
    if (height != null) 'Height': height,
    if (email != null) 'Email': email,
  };
}
