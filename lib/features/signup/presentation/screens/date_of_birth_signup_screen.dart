import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/login_shell_screen.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/dob_picker_signup_widget.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/header_signup_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class DateOfBirthSignupScreen extends ConsumerWidget {
  const DateOfBirthSignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoginShellScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderSignupWidget(),
          const SizedBox(height: 100),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'What\'s your date of birth?',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          DobPickerSignupWidget(),
          SizedBox(height: 100),
          MetricButtonWidget(
            text: 'Next',
            isEnabled: true,
            onPressed: () async {
              await ref.read(signupProvider.notifier).navigateToNextStep();
            },
          ),
        ],
      ),
    );
  }
}
