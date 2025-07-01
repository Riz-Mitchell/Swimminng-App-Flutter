import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/providers/user_provider.dart';

class EnterTextWidget extends ConsumerWidget {
  final String text;

  const EnterTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(createUserProvider);
    final userNotifier = ref.read(createUserProvider.notifier);

    return TextField(
      decoration: InputDecoration(
        hintText: text,
        hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2, // thicker when focused
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      onChanged: (newName) {
        userNotifier.state = user.copyWith(name: newName);
      },
    );
  }
}
