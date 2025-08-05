import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogSwimsShellScreen extends ConsumerWidget {
  final Widget child;

  const LogSwimsShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
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
