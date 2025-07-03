import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/core/router.dart';
import 'package:swimming_app_frontend/features/auth/logic/create_acc_controller.dart';
import 'package:swimming_app_frontend/providers/create_user_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

class ButtonWidget extends ConsumerWidget {
  final String text;

  const ButtonWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createUser = ref.watch(createUserProvider);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          ref.read(createAccControllerProvider.notifier).next();
          print('name: ${createUser.name}');
          print('date of birth: ${createUser.dateOfBirth}');
          print('height: ${createUser.height}');
          print('sex: ${createUser.sex}');
          print('phoneNumber: ${createUser.phoneNumber}');
        },
        child: Text(
          'Next',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
