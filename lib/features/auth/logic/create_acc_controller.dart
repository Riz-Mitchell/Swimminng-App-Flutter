import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/core/router.dart';

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

  void next() {
    switch (state) {
      case CreateAccStatus.initial:
        state = CreateAccStatus.addName;
        ref.read(routerProvider).go('/ca-add-name');
        break;
      case CreateAccStatus.addName:
        state = CreateAccStatus.addDOB;
        ref.read(routerProvider).go('/ca-add-dob');
        break;
      case CreateAccStatus.addDOB:
        state = CreateAccStatus.addHeight;
        ref.read(routerProvider).go('/ca-add-height');
        break;
      case CreateAccStatus.addHeight:
        state = CreateAccStatus.addSex;
        ref.read(routerProvider).go('/ca-add-sex');
        break;
      case CreateAccStatus.addSex:
        state = CreateAccStatus.addPhoneNumber;
        ref.read(routerProvider).go('/ca-add-phone-number');
        break;
      case CreateAccStatus.addPhoneNumber:
        state = CreateAccStatus.verifyPhoneNumber;
        ref.read(routerProvider).go('/ca-verify-phone-number');
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

  final createAccControllerProvider =
      StateNotifierProvider<CreateAccController, CreateAccStatus>(
        (ref) => CreateAccController(ref),
      );
}
