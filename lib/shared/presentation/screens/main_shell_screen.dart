import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainShellScreen extends ConsumerWidget {
  final List<Widget> children;

  const MainShellScreen({super.key, required this.children});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is the main shell screen that will be used to navigate between different features of the app.
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
