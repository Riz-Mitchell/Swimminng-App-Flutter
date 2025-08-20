import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutsideShellScreen extends ConsumerWidget {
  final Widget child;

  const OutsideShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is the outside shell screen that will be used to display content without the main navigation
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
