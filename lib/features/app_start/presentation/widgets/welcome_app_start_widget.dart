import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';

class WelcomeAppStartWidget extends ConsumerStatefulWidget {
  const WelcomeAppStartWidget({super.key});

  @override
  ConsumerState<WelcomeAppStartWidget> createState() =>
      _WelcomeAppStartWidgetState();
}

class _WelcomeAppStartWidgetState extends ConsumerState<WelcomeAppStartWidget> {
  @override
  void initState() {
    super.initState();

    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      ref.read(routerProvider).go('/login-or-signup');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
              'Inteli',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            )
            .animate()
            .fadeIn(
              duration: 500.ms,
              curve: Curves.fastEaseInToSlowEaseOut,
              delay: 100.ms,
            )
            .move(
              begin: const Offset(0, 50),
              end: Offset.zero,
              duration: 400.ms,
              curve: Curves.fastEaseInToSlowEaseOut,
              delay: 1000.ms,
            ),
        Text(
              'Swim',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            )
            .animate()
            .fadeIn(
              duration: 500.ms,
              curve: Curves.fastEaseInToSlowEaseOut,
              delay: 600.ms, // start after Inteli finishes
            )
            .move(
              begin: const Offset(0, 50),
              end: Offset.zero,
              duration: 400.ms,
              curve: Curves.fastEaseInToSlowEaseOut,
              delay: 1000.ms,
            ),
      ],
    );
  }
}
