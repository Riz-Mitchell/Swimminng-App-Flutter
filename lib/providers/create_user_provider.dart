import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/user_model.dart';

final createUserProvider = StateProvider<CreateUserReqDTO>((ref) {
  return CreateUserReqDTO(
    name: '',
    phoneNumber: '',
    dateOfBirth: DateTime.now(),
    userType: UserType.swimmer, // or whatever default makes sense
  );
});
