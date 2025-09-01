import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/welcome_app_start_widget.dart';

class LaunchAppStartScreen extends ConsumerWidget {
  const LaunchAppStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(child: WelcomeAppStartWidget()), // visual only
    );
  }
}
