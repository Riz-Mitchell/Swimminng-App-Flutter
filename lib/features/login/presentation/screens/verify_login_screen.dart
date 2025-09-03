import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/application/login_provider.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/login_shell_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/widgets/header_login_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/verify_widget.dart';

final isVerifyingProvider = StateProvider<bool>((ref) => false);

class VerifyLoginScreen extends ConsumerWidget {
  const VerifyLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
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
              'Enter your verification code.',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          SizedBox(height: 20),
          VerifyWidget(
            onCompleted: (value) async {
              await ref
                  .read(loginProvider.notifier)
                  .updateLoginForm(otp: value);
              await ref.read(loginProvider.notifier).pushToLoginDone();
            },
          ),
          SizedBox(height: 20),
          if (loginState.errorMessage != null)
            Text(
              '${loginState.errorMessage}',
              style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
            ),
        ],
      ),
    );
  }
}
