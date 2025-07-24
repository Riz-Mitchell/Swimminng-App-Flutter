import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/app_start/application/providers/splash_status_provider.dart';

class WelcomeAppStartWidget extends ConsumerWidget {
  const WelcomeAppStartWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(splashStatusProvider);

    final firstOpacity = status.index >= SplashStatus.showFirstText.index
        ? 1.0
        : 0.0;
    final secondOpacity = status.index >= SplashStatus.showSecondText.index
        ? 1.0
        : 0.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: firstOpacity,
          duration: const Duration(seconds: 2),
          child: Text(
            'Welcome to',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: secondOpacity,
          duration: const Duration(seconds: 2),
          child: Text(
            'Splashbook',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      ],
    );
  }
}
