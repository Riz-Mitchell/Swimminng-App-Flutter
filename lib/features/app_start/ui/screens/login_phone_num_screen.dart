import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';
import 'package:swimming_app_frontend/features/app_start/logic/user_login_controller.dart';
import 'package:swimming_app_frontend/features/auth/ui/widgets/button_widget.dart';
import 'package:swimming_app_frontend/features/auth/ui/widgets/enter_text_widget.dart';
import 'package:swimming_app_frontend/features/auth/ui/widgets/phone_number_input_widget.dart';
import 'package:swimming_app_frontend/providers/login_user_provider.dart';

class LoginPhoneNumScreen extends ConsumerWidget {
  const LoginPhoneNumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestOtp = ref.watch(otpReqProvider);
    final requestOtpNotifier = ref.read(otpReqProvider.notifier);

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
                          'What is your phone number?',
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onBackground,
                              ),
                        ),
                      ),
                      PhoneNumberInputWidget(
                        onChanged: (value) {
                          // Enter phone number associated with acc to login
                          requestOtpNotifier.state = requestOtp.copyWith(
                            phoneNum: value,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ButtonWidget(
                  text: 'Next',
                  onPressed: () =>
                      ref.read(userLoginControllerProvider.notifier).next(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
