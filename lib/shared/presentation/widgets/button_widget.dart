import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/application/providers/form/signup_form_provider.dart';
import 'package:swimming_app_frontend/features/signup/application/providers/navigation/signup_navigation_provider.dart';

class ButtonWidget extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;

  const ButtonWidget({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupForm = ref.watch(signupFormProvider);
    final userCreationStatusNotifier = ref.read(
      signupNavigationProvider.notifier,
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          if (onPressed == null) {
            userCreationStatusNotifier.next();
            print('name: ${signupForm.name}');
            print('date of birth: ${signupForm.dateOfBirth}');
            print('height: ${signupForm.height}');
            // print('sex: ${postUserReq.sex}');
            print('phoneNumber: ${signupForm.phoneNumber}');
          } else {
            onPressed?.call();
          }
        },
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
