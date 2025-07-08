import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';
import 'package:swimming_app_frontend/api/services/user_service.dart';
import 'package:swimming_app_frontend/features/auth/logic/create_acc_controller.dart';
import 'package:swimming_app_frontend/providers/create_user_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

class VerifyWidget extends ConsumerWidget {
  final Function(String)? onCompleted;

  const VerifyWidget({super.key, this.onCompleted});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createUserReq = ref.watch(createUserProvider);
    final userService = ref.read(userServiceProvider);

    return Pinput(
      length: 6,
      onCompleted: (code) async {
        if (onCompleted == null) {
          print('Verification code entered: $code');
          final success = await userService.verifyUserAndLogin(
            LoginReqDTO(phoneNum: createUserReq.phoneNumber, otp: code),
          );

          if (success) {
            ref.read(createAccControllerProvider.notifier).next();
            print('Verification successful, proceeding to next step.');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid code. Please try again.')),
            );
          }
        } else {
          onCompleted!(code);
        }
      },
    );
  }
}
