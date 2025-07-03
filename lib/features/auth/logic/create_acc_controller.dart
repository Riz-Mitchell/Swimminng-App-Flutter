import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/core/router.dart';
import 'package:swimming_app_frontend/features/auth/logic/auth_provider.dart';
import 'package:swimming_app_frontend/providers/create_user_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

enum CreateAccStatus {
  initial,
  addName,
  addDOB,
  addHeight,
  addSex,
  addPhoneNumber,
  verifyPhoneNumber,
  done,
}

class CreateAccController extends StateNotifier<CreateAccStatus> {
  final Ref ref;
  CreateAccController(this.ref) : super(CreateAccStatus.initial);

  Future<void> next() async {
    final current = ref.read(createUserProvider);

    switch (state) {
      case CreateAccStatus.initial:
        state = CreateAccStatus.addName;
        ref.read(routerProvider).go('/ca-add-name');
        break;
      case CreateAccStatus.addName:
        if (current.name.length < 3) return;
        state = CreateAccStatus.addDOB;
        ref.read(routerProvider).go('/ca-add-dob');
        break;
      case CreateAccStatus.addDOB:
        state = CreateAccStatus.addHeight;
        ref.read(routerProvider).go('/ca-add-height');
        break;
      case CreateAccStatus.addHeight:
        if (current.height == null || current.height! <= 0) return;
        state = CreateAccStatus.addSex;
        ref.read(routerProvider).go('/ca-add-sex');
        break;
      case CreateAccStatus.addSex:
        if (current.sex == null) return;
        state = CreateAccStatus.addPhoneNumber;
        ref.read(routerProvider).go('/ca-add-phone-number');
        break;
      case CreateAccStatus.addPhoneNumber:
        if (current.phoneNumber.isEmpty) print('empty');
        try {
          final userService = ref.read(userServiceProvider);
          print("Creating user and sending OTP for \n${current.toJson()}");
          await userService.createUserAndSendVerifyCode(current);
          print("OTP sent");

          state = CreateAccStatus.verifyPhoneNumber;
          ref.read(routerProvider).go('/ca-verify-phone-number');
        } catch (e) {
          // Show a snackbar or log error
          print('Error creating user or sending OTP: $e');
          // optionally: show retry or remain on same page
        }
        break;
      case CreateAccStatus.verifyPhoneNumber:
        state = CreateAccStatus.done;
        ref.read(routerProvider).go('/ca-done');
        break;
      case CreateAccStatus.done:
        break;
    }
  }

  void back() {
    switch (state) {
      case CreateAccStatus.initial:
        break;
      case CreateAccStatus.addName:
        state = CreateAccStatus.initial;
        ref.read(routerProvider).go('/ca-initial');
        break;
      case CreateAccStatus.addDOB:
        state = CreateAccStatus.addName;
        ref.read(routerProvider).go('/ca-add-name');
        break;
      case CreateAccStatus.addHeight:
        state = CreateAccStatus.addDOB;
        ref.read(routerProvider).go('/ca-add-dob');
        break;
      case CreateAccStatus.addSex:
        state = CreateAccStatus.addHeight;
        ref.read(routerProvider).go('/ca-add-height');
        break;
      case CreateAccStatus.addPhoneNumber:
        state = CreateAccStatus.addSex;
        ref.read(routerProvider).go('/ca-add-sex');
        break;
      case CreateAccStatus.verifyPhoneNumber:
        state = CreateAccStatus.addPhoneNumber;
        ref.read(routerProvider).go('/ca-add-phone-number');
        break;
      case CreateAccStatus.done:
        state = CreateAccStatus.verifyPhoneNumber;
        ref.read(routerProvider).go('/ca-verify-phone-number');
        break;
    }
  }

  Future<void> submit() async {
    final user = ref.read(createUserProvider);

    // if (!user.isComplete) return;

    try {
      // await ref.read(authProvider.notifier).registerUser(user.toJson());
      print('submitting user: ${user.toJson()}');
    } catch (e) {
      // Show error to user
    }
  }
}

final createAccControllerProvider =
    StateNotifierProvider<CreateAccController, CreateAccStatus>(
      (ref) => CreateAccController(ref),
    );
