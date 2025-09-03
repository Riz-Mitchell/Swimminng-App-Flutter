import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/application/login_provider.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/login_shell_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/widgets/header_login_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class DoneLoginScreen extends ConsumerWidget {
  const DoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoginShellScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderLoginWidget(donePage: true),
          const SizedBox(height: 100),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Welcome to InteliSwim.',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'It\'s time to put your thinking hat on!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          SizedBox(height: 100),
          MetricButtonWidget(
            text: 'Get to work',
            onPressed: () async {
              ref.read(loginProvider.notifier).exitToHome();
            },
          ),
        ],
      ),
    );
  }
}
