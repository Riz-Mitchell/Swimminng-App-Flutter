import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/login_shell_screen.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/enter_text_signup_widget.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/header_signup_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class NameSignupScreen extends ConsumerWidget {
  const NameSignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return LoginShellScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderSignupWidget(),
          const SizedBox(height: 100),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'What do you go by?',
              style: textTheme.headlineLarge?.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
          ),
          SizedBox(height: 50),
          EnterTextSignupWidget(text: 'Name'),
          SizedBox(height: 5),
          Text(
            textAlign: TextAlign.left,
            'This is the name that will be displayed on your profile.',
            style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary),
          ),
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
