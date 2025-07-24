import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/application/providers/auth_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';

enum SignupPage {
  initial,
  addName,
  addDOB,
  addHeight,
  addSex,
  addPhoneNumber,
  verifyPhoneNumber,
  done,
}

class SignupNavigationController extends Notifier<SignupPage> {
  @override
  SignupPage build() => SignupPage.initial;

  Future<void> next() async {
    switch (state) {
      case SignupPage.initial:
        state = SignupPage.addName;
        ref.read(routerProvider).go('/ca-add-name');
        break;
      case SignupPage.addName:
        state = SignupPage.addDOB;
        ref.read(routerProvider).go('/ca-add-dob');
        break;
      case SignupPage.addDOB:
        state = SignupPage.addHeight;
        ref.read(routerProvider).go('/ca-add-height');
        break;
      case SignupPage.addHeight:
        state = SignupPage.addSex;
        ref.read(routerProvider).go('/ca-add-sex');
        break;
      case SignupPage.addSex:
        state = SignupPage.addPhoneNumber;
        ref.read(routerProvider).go('/ca-add-phone-number');
        break;
      case SignupPage.addPhoneNumber:
        await ref.read(authControllerProvider.notifier).signup();
        state = SignupPage.verifyPhoneNumber;
        break;
      case SignupPage.verifyPhoneNumber:
        await ref.read(authControllerProvider.notifier).login();

        state = SignupPage.done;
        ref.read(routerProvider).go('/ca-done');
        break;
      case SignupPage.done:
        break;
    }
  }
}

final signupNavigationProvider =
    NotifierProvider<SignupNavigationController, SignupPage>(
      () => SignupNavigationController(),
    );
