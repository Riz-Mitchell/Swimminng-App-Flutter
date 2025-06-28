import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firstOpacityProvider = StateProvider<double>((ref) => 0.0);
final secondOpacityProvider = StateProvider<double>((ref) => 0.0);
final welcomeCompleteProvider = StateProvider<bool>((ref) => false);

class Welcome extends ConsumerWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstOpacity = ref.watch(firstOpacityProvider);
    final secondOpacity = ref.watch(secondOpacityProvider);

    // Trigger the fade-in once the widget is built
    Future.microtask(() async {
      final first = ref.read(firstOpacityProvider.notifier);
      final second = ref.read(secondOpacityProvider.notifier);

      if (first.state == 0.0 && second.state == 0.0) {
        first.state = 1.0;
        await Future.delayed(const Duration(seconds: 3)); // fade + wait
        second.state = 1.0;
        await Future.delayed(
          const Duration(seconds: 3),
        ); // allow second to fade in
        ref.read(welcomeCompleteProvider.notifier).state = true;
      }
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: firstOpacity,
          duration: const Duration(seconds: 2),
          child: Text(
            'Welcome to',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        AnimatedOpacity(
          opacity: secondOpacity,
          duration: const Duration(seconds: 2),
          child: Text(
            'Splashbook',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ],
    );
  }
}
