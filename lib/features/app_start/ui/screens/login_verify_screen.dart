import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';
import 'package:swimming_app_frontend/features/app_start/logic/user_login_controller.dart';
import 'package:swimming_app_frontend/features/auth/ui/widgets/button_widget.dart';
import 'package:swimming_app_frontend/features/auth/ui/widgets/enter_text_widget.dart';
import 'package:swimming_app_frontend/features/auth/ui/widgets/verify_widget.dart';
import 'package:swimming_app_frontend/providers/login_user_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

class LoginVerifyScreen extends ConsumerWidget {
  const LoginVerifyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestOtp = ref.read(otpReqProvider);
    final userService = ref.read(userServiceProvider);

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
                          'Check your messages',
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onBackground,
                              ),
                        ),
                      ),
                      VerifyWidget(
                        onCompleted: (value) async {
                          final otpReqPhoneNum = requestOtp.phoneNum;
                          print(
                            'sending phonenum: ${otpReqPhoneNum} and otp: ${value}',
                          );
                          final success = await userService.verifyUserAndLogin(
                            LoginReqDTO(phoneNum: otpReqPhoneNum, otp: value),
                          );

                          if (success) {
                            ref
                                .read(userLoginControllerProvider.notifier)
                                .next();
                          } else {
                            print('error with otp');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
