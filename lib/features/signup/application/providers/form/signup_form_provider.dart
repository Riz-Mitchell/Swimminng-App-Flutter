import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/application/providers/selected_sex_status_provider.dart';
import 'package:swimming_app_frontend/shared/domain/models/user_model.dart';

class SignupForm extends Notifier<CreateUserReqDTO> {
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

  void updateSex(SelectedSexStatus sex) {
    if (sex == SelectedSexStatus.male) {
      state = state.copyWith(sex: Sex.male);
    } else if (sex == SelectedSexStatus.female) {
      state = state.copyWith(sex: Sex.female);
    } else {
      print('Sex not selected (PostUserReqNotifier.updateSex())');
    }
  }
}

final signupFormProvider = NotifierProvider<SignupForm, CreateUserReqDTO>(
  () => SignupForm(),
);
