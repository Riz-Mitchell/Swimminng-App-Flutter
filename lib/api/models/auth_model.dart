class OTPRequest {
  final String phoneNum;

  OTPRequest({required this.phoneNum});

  Map<String, dynamic> toJson() => {'PhoneNum': phoneNum};
}

class LoginRequest {
  final String phoneNum;
  final String otp;

  LoginRequest({required this.phoneNum, required this.otp});

  Map<String, dynamic> toJson() => {'PhoneNum': phoneNum, 'OTP': otp};
}
