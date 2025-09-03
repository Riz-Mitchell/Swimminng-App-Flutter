import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/login_shell_screen.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/header_signup_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/phone_number_input_widget.dart';

class PhoneNumberSignupScreen extends ConsumerWidget {
  const PhoneNumberSignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final signupState = ref.watch(signupProvider);

    final isValid = signupState.signupForm.isPhoneNumberValid();

    return LoginShellScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderSignupWidget(),
          const SizedBox(height: 100),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'What is your phone number?',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          SizedBox(height: 20),
          PhoneNumInputWidget(
            onChanged: (phoneNumber) {
              ref
                  .read(signupProvider.notifier)
                  .updateSignupForm(phoneNumber: phoneNumber);
            },
          ),
          SizedBox(height: 20),
          if (signupState.errorMessage != null)
            Text(
              textAlign: TextAlign.center,
              '${signupState.errorMessage}',
              style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
            ),
          SizedBox(height: 100),
          MetricButtonWidget(
            text: 'Next',
            isEnabled: (isValid),
            onPressed: () async {
              await ref.read(signupProvider.notifier).navigateToNextStep();
            },
          ),
        ],
      ),
    );
  }
}
