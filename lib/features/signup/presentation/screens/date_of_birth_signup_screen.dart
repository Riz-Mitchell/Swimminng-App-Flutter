import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/dob_picker_signup_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/button_widget.dart';

class DateOfBirthSignupScreen extends ConsumerWidget {
  const DateOfBirthSignupScreen({super.key});

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
                          'How old are you?',
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onBackground,
                              ),
                        ),
                      ),
                      DobPickerSignupWidget(),
                    ],
                  ),
                ),
                ButtonWidget(text: 'Next'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
