import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/login_shell_screen.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/header_signup_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/verify_widget.dart';

class VerifySignupScreen extends ConsumerWidget {
  const VerifySignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final signupState = ref.watch(signupProvider);

    return LoginShellScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderSignupWidget(),
          const SizedBox(height: 100),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Enter your verification code.',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          SizedBox(height: 20),
          VerifyWidget(
            onCompleted: (code) async {
              final phoneNumber = signupState.signupForm.phoneNumber;
              await ref
                  .read(signupProvider.notifier)
                  .updateLoginForm(phoneNumber: phoneNumber, otp: code);
              await ref.read(signupProvider.notifier).navigateToNextStep();
            },
          ),
          SizedBox(height: 20),
          if (signupState.errorMessage != null)
            Text(
              '${signupState.errorMessage}',
              style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
            ),
        ],
      ),
    );
  }
}
