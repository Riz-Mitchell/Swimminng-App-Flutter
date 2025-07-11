import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/user_creation_status_provider.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/post_user_req_provider.dart';

class ButtonWidget extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;

  const ButtonWidget({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postUserReq = ref.watch(postUserReqProvider);
    final userCreationStatusNotifier = ref.read(
      userCreationStatusProvider.notifier,
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
            print('name: ${postUserReq.name}');
            print('date of birth: ${postUserReq.dateOfBirth}');
            print('height: ${postUserReq.height}');
            // print('sex: ${postUserReq.sex}');
            print('phoneNumber: ${postUserReq.phoneNumber}');
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
