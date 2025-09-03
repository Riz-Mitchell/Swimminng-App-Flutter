import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/application/login_provider.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/login_shell_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/widgets/header_login_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/phone_number_input_widget.dart';

class PhoneNumLoginScreen extends ConsumerWidget {
  const PhoneNumLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return LoginShellScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderLoginWidget(),
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
            onChanged: (value) {
              loginNotifier.updateLoginForm(phoneNumber: value);
            },
          ),
          SizedBox(height: 20),
          if (loginState.errorMessage != null)
            Text(
              textAlign: TextAlign.center,
              '${loginState.errorMessage}',
              style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
            ),
          SizedBox(height: 100),
          MetricButtonWidget(
            text: 'Next',
            isEnabled: (loginState.loginForm.isPhoneNumberValid()),
            onPressed: () async =>
                await ref.read(loginProvider.notifier).pushToLoginVerify(),
          ),
        ],
      ),
    );
  }
}
