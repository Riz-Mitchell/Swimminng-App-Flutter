import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/application/providers/navigation/login_navigation_provider.dart';
import 'package:swimming_app_frontend/features/signup/application/providers/form/login_form_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/button_widget.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/phone_number_input_widget.dart';
import 'package:swimming_app_frontend/shared/application/providers/form/verify_form_provider.dart';

class LoginPhoneNumScreen extends ConsumerWidget {
  const LoginPhoneNumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verifyFormNotifier = ref.read(verifyFormProvider.notifier);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                      'What is your phone number?',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  PhoneNumberInputWidget(
                    onChanged: (value) {
                      verifyFormNotifier.setPhoneNum(value);
                      ref.read(loginFormProvider.notifier).setPhoneNum(value);
                    },
                  ),
                ],
              ),
              ButtonWidget(
                text: 'Next',
                onPressed: () =>
                    ref.read(loginNavigationProvider.notifier).next(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
