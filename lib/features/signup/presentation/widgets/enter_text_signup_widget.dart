import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';

final nameControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final controller = TextEditingController(
    text: ref.read(signupProvider).signupForm.name, // initial value
  );

  // When the controller text changes, update your state
  controller.addListener(() {
    ref.read(signupProvider.notifier).updateSignupForm(name: controller.text);
  });

  // Dispose controller when provider is disposed
  ref.onDispose(controller.dispose);

  return controller;
});

class EnterTextSignupWidget extends ConsumerWidget {
  final String text;

  const EnterTextSignupWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(nameControllerProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final signupState = ref.watch(signupProvider);

    final isValid = signupState.signupForm.isNameValid();

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.secondary),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: (isValid) ? colorScheme.primary : colorScheme.error,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: (isValid) ? colorScheme.primary : colorScheme.error,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1, // thicker when focused
            color: (isValid) ? colorScheme.primary : colorScheme.error,
          ),
        ),
      ),
    );
  }
}
