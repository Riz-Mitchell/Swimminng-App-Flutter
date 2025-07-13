import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';
import 'package:swimming_app_frontend/features/login/providers/navigation/login_navigation_provider.dart';
import 'package:swimming_app_frontend/features/signup/providers/form/login_form_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/verify_widget.dart';
import 'package:swimming_app_frontend/shared/providers/form/verify_form_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

final isVerifyingProvider = StateProvider<bool>((ref) => false);

class LoginVerifyScreen extends ConsumerWidget {
  const LoginVerifyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      onCompleted: (value) {
                        ref.read(loginFormProvider.notifier).setOTP(value);
                        ref.read(loginNavigationProvider.notifier).next();
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
