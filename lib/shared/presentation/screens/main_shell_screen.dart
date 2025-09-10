import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/inteli_swim_navigation_bar_widget.dart';

class MainShellScreen extends ConsumerWidget {
  final Widget child;
  final bool profileOverride;

  const MainShellScreen({
    super.key,
    this.profileOverride = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is the main shell screen that will be used to navigate between different features of the app.
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SingleChildScrollView(
            child: Container(
              margin: (profileOverride)
                  ? const EdgeInsets.only(
                      top: 0,
                      left: 12,
                      right: 12,
                      bottom: 0,
                    )
                  : const EdgeInsets.only(
                      top: 70,
                      left: 12,
                      right: 12,
                      bottom: 0,
                    ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
