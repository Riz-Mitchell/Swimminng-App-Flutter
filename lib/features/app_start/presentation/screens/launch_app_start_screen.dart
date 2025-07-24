import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/app_start/application/providers/splash_status_provider.dart';
import 'package:swimming_app_frontend/features/app_start/presentation/widgets/expanding_circle_app_start_widget.dart';
import '../widgets/welcome_app_start_widget.dart';

class LaunchAppStartScreen extends ConsumerStatefulWidget {
  const LaunchAppStartScreen({super.key});

  @override
  ConsumerState<LaunchAppStartScreen> createState() =>
      _LaunchAppStartScreenState();
}

class _LaunchAppStartScreenState extends ConsumerState<LaunchAppStartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(splashStatusProvider.notifier).start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Center(child: WelcomeAppStartWidget()), // visual only
        ),
        const ExpandingCircleAppStartWidget(), // reacts to controller state
      ],
    );
  }
}
