import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/post_user_req_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

class EnterTextWidget extends ConsumerWidget {
  final String text;

  const EnterTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postUserReq = ref.watch(postUserReqProvider);
    final postUserReqNotifier = ref.read(postUserReqProvider.notifier);

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
        postUserReqNotifier.updateName(newName);
      },
    );
  }
}
