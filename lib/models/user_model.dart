class CreateUser {
  final String? name;
  final String? phoneNum;
  final DateTime? dateOfBirth;
  final double? height;
  final String? sex;
  final String? userType;

  CreateUser({
    this.name,
    this.phoneNum,
    this.dateOfBirth,
    this.height,
    this.sex,
    this.userType,
  });

  CreateUser copyWith({
    String? name,
    String? phoneNum,
    DateTime? dateOfBirth,
    double? height,
    String? sex,
    String? userType,
  }) {
    return CreateUser(
      name: name ?? this.name,
      phoneNum: phoneNum ?? this.phoneNum,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      sex: sex ?? this.sex,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'PhoneNum': phoneNum,
      'DateOfBirth': dateOfBirth?.toIso8601String(),
      'Height': height,
      'Sex': sex,
      'UserType': userType,
    };
  }

  bool get isComplete =>
      name != null &&
      phoneNum != null &&
      dateOfBirth != null &&
      height != null &&
      sex != null &&
      userType != null;
}
