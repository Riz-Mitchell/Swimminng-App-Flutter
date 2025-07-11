import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';
import 'package:swimming_app_frontend/features/user_login/providers/user_login_controller.dart';
import 'package:swimming_app_frontend/features/user_creation/presentation/widgets/verify_widget.dart';
import 'package:swimming_app_frontend/providers/login_user_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

final isVerifyingProvider = StateProvider<bool>((ref) => false);

class LoginVerifyScreen extends ConsumerWidget {
  const LoginVerifyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestOtp = ref.read(otpReqProvider);
    final userService = ref.read(userServiceProvider);
    final isVerifying = ref.watch(isVerifyingProvider); // for UI if needed

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
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Check your messages',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ),
                    VerifyWidget(
                      onCompleted: (value) async {
                        if (ref.read(isVerifyingProvider)) return;

                        // mark as verifying
                        ref.read(isVerifyingProvider.notifier).state = true;

                        final otpReqPhoneNum = ref
                            .read(otpReqProvider)
                            .phoneNum;

                        if (otpReqPhoneNum.isEmpty || value.isEmpty) {
                          print('phone or otp is empty. Ignoring request.');
                          return;
                        }

                        print(
                          'sending phonenum: $otpReqPhoneNum and otp: $value',
                        );

                        final success = await userService.verifyUserAndLogin(
                          LoginReqDTO(phoneNum: otpReqPhoneNum, otp: value),
                        );

                        if (success) {
                          // Prevent any future re-calls no matter what
                          ref.invalidate(isVerifyingProvider);

                          // Navigate
                          ref.read(userLoginControllerProvider.notifier).next();
                        } else {
                          print('error with otp');
                          ref.read(isVerifyingProvider.notifier).state = false;
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
