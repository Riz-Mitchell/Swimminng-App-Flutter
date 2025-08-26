import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/login_shell_screen.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/header_signup_widget.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/height_picker_signup_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class HeightSignupScreen extends ConsumerWidget {
  const HeightSignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('here');

    return LoginShellScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderSignupWidget(),
          const SizedBox(height: 100),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'How tall are you?',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          HeightPickerSignupWidget(),
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
