import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/app_start/logic/app_start_controller.dart';
import 'package:swimming_app_frontend/features/app_start/ui/widgets/expanding_circle_widget.dart';
import '../widgets/welcome_title_widget.dart';

class AppStartScreen extends ConsumerStatefulWidget {
  const AppStartScreen({super.key});

  @override
  ConsumerState<AppStartScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends ConsumerState<AppStartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(splashControllerProvider.notifier).start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Center(child: Welcome()), // visual only
        ),
        const ExpandingCircle(), // reacts to controller state
      ],
    );
  }
}
