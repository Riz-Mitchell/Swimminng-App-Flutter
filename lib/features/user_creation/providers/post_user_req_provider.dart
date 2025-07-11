import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/user_model.dart';

class PostUserReqNotifier extends Notifier<CreateUserReqDTO> {
  @override
  CreateUserReqDTO build() {
    return CreateUserReqDTO(
      name: '',
      phoneNumber: '',
      height: null,
      sex: null,
      dateOfBirth: DateTime.now(),
      userType: UserType.swimmer,
    );
  }

  void updateName(String newName) {
    state = state.copyWith(name: newName);
  }

  void updatePhoneNumber(String newPhone) {
    state = state.copyWith(phoneNumber: newPhone);
  }

  void updateDateOfBirth(DateTime newDob) {
    state = state.copyWith(dateOfBirth: newDob);
  }

  void updateUserType(UserType newType) {
    state = state.copyWith(userType: newType);
  }

  void updateHeight(double height) {
    state = state.copyWith(height: height);
  }

  void updateSex(Sex sex) {
    state = state.copyWith(sex: sex);
  }
}

final postUserReqProvider =
    NotifierProvider<PostUserReqNotifier, CreateUserReqDTO>(
      () => PostUserReqNotifier(),
    );
