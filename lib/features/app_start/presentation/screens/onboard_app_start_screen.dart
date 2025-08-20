import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/button_widget.dart';

class OnboardAppStartScreen extends ConsumerWidget {
  const OnboardAppStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 220, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    spacing: 30,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Welcome to InteliSwim',
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onBackground,
                              ),
                        ),
                      ),
                      // Smaller widget here
                    ],
                  ),
                ),
                ButtonWidget(
                  text: 'Login',
                  onPressed: () {
                    ref.read(routerProvider).go('/login-phonenumber');
                  },
                ),
                ButtonWidget(
                  text: 'Signup',
                  onPressed: () {
                    ref.read(routerProvider).go('/ca-initial');
                  },
                ),
                ButtonWidget(
                  text: 'Link External Swims',
                  onPressed: () {
                    ref.read(routerProvider).go('/link-external-swims');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
