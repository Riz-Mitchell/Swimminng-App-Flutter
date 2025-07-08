class OTPReqDTO {
  final String phoneNum;

  const OTPReqDTO({required this.phoneNum});

  OTPReqDTO copyWith({String? phoneNum}) {
    return OTPReqDTO(phoneNum: phoneNum ?? this.phoneNum);
  }

  Map<String, dynamic> toJson() => {'phoneNum': phoneNum};
}

class LoginReqDTO {
  final String phoneNum;
  final String otp;

  const LoginReqDTO({required this.phoneNum, required this.otp});

  LoginReqDTO copyWith({String? phoneNum, String? otp}) {
    return LoginReqDTO(
      phoneNum: phoneNum ?? this.phoneNum,
      otp: otp ?? this.otp,
    );
  }

  Map<String, dynamic> toJson() => {'phoneNum': phoneNum, 'otp': otp};
}
