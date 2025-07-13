import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:swimming_app_frontend/features/signup/providers/form/login_form_provider.dart';
import 'package:swimming_app_frontend/features/signup/providers/form/signup_form_provider.dart';
import 'package:swimming_app_frontend/features/signup/providers/navigation/signup_navigation_provider.dart';

class VerifyWidget extends ConsumerWidget {
  final Function(String)? onCompleted;

  const VerifyWidget({super.key, this.onCompleted});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupNavigationNotifier = ref.read(
      signupNavigationProvider.notifier,
    );
    final signupForm = ref.watch(signupFormProvider);
    final loginFormNotifier = ref.read(loginFormProvider.notifier);

    return Pinput(
      length: 6,
      onCompleted: (code) async {
        if (onCompleted == null) {
          loginFormNotifier.setOTP(code);

          signupNavigationNotifier.next();
        } else {
          onCompleted!(code);
        }
      },
    );
  }
}
