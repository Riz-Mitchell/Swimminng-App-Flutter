import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/user_model.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/login_user_req_provider.dart';
import 'package:swimming_app_frontend/shared/router.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/post_user_req_provider.dart';
import 'package:swimming_app_frontend/providers/storage_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

enum UserCreationStatus {
  initial,
  addName,
  addDOB,
  addHeight,
  addSex,
  addPhoneNumber,
  verifyPhoneNumber,
  done,
}

class UserCreationStatusNotifier extends Notifier<UserCreationStatus> {
  @override
  UserCreationStatus build() => UserCreationStatus.initial;

  Future<void> next() async {
    final postUserReqNotifier = ref.read(postUserReqProvider.notifier);
    final postUserReq = ref.read(postUserReqProvider);
    final storage = ref.read(storageProvider);

    switch (state) {
      case UserCreationStatus.initial:
        state = UserCreationStatus.addName;
        ref.read(routerProvider).go('/ca-add-name');
        break;
      case UserCreationStatus.addName:
        if (postUserReq.name.length < 3) return;
        state = UserCreationStatus.addDOB;
        ref.read(routerProvider).go('/ca-add-dob');
        break;
      case UserCreationStatus.addDOB:
        state = UserCreationStatus.addHeight;
        ref.read(routerProvider).go('/ca-add-height');
        break;
      case UserCreationStatus.addHeight:
        if (postUserReq.height == null || postUserReq.height! <= 0) return;
        state = UserCreationStatus.addSex;
        ref.read(routerProvider).go('/ca-add-sex');
        break;
      case UserCreationStatus.addSex:
        if (postUserReq.sex == null) return;
        state = UserCreationStatus.addPhoneNumber;
        ref.read(routerProvider).go('/ca-add-phone-number');
        break;
      case UserCreationStatus.addPhoneNumber:
        if (postUserReq.phoneNumber.isEmpty) print('empty');
        try {
          GetUserResDTO newUser = await postUserReqNotifier.submitAsync();
          await storage.setUserId(
            newUser.id,
          ); // Save the userId for future requests
          print("OTP sent");

          state = UserCreationStatus.verifyPhoneNumber;
          ref.read(routerProvider).go('/ca-verify-phone-number');
        } catch (e) {
          // Show a snackbar or log error
          print('Error creating user or sending OTP: $e');
          // optionally: show retry or remain on same page
        }
        break;
      case UserCreationStatus.verifyPhoneNumber:
        bool loginSuccess = await ref
            .read(loginUserReqProvider.notifier)
            .submitAsync();

        if (loginSuccess) {
          print('login worked');
        } else {
          print('login didn\'t work');
        }

        state = UserCreationStatus.done;
        ref.read(routerProvider).go('/ca-done');
        break;
      case UserCreationStatus.done:
        break;
    }
  }

  void back() {
    switch (state) {
      case UserCreationStatus.initial:
        break;
      case UserCreationStatus.addName:
        state = UserCreationStatus.initial;
        ref.read(routerProvider).go('/ca-initial');
        break;
      case UserCreationStatus.addDOB:
        state = UserCreationStatus.addName;
        ref.read(routerProvider).go('/ca-add-name');
        break;
      case UserCreationStatus.addHeight:
        state = UserCreationStatus.addDOB;
        ref.read(routerProvider).go('/ca-add-dob');
        break;
      case UserCreationStatus.addSex:
        state = UserCreationStatus.addHeight;
        ref.read(routerProvider).go('/ca-add-height');
        break;
      case UserCreationStatus.addPhoneNumber:
        state = UserCreationStatus.addSex;
        ref.read(routerProvider).go('/ca-add-sex');
        break;
      case UserCreationStatus.verifyPhoneNumber:
        state = UserCreationStatus.addPhoneNumber;
        ref.read(routerProvider).go('/ca-add-phone-number');
        break;
      case UserCreationStatus.done:
        state = UserCreationStatus.verifyPhoneNumber;
        ref.read(routerProvider).go('/ca-verify-phone-number');
        break;
    }
  }
}

final userCreationStatusProvider =
    NotifierProvider<UserCreationStatusNotifier, UserCreationStatus>(
      () => UserCreationStatusNotifier(),
    );
