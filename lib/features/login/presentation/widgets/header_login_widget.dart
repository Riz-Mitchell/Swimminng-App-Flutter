import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/application/login_provider.dart';
import 'package:swimming_app_frontend/features/login/domain/enum/login_status_enum.dart';
import 'package:swimming_app_frontend/features/login/presentation/widgets/progress_icon_login_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class HeaderLoginWidget extends ConsumerWidget {
  final bool donePage;

  const HeaderLoginWidget({super.key, this.donePage = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 40, height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            ProgressIconLoginWidget(
              status: LoginStatusEnum.addPhoneNumber,
              completed:
                  LoginStatusEnum.addPhoneNumber.index <
                      loginState.status.index ||
                  donePage,
              isUsing:
                  loginState.status == LoginStatusEnum.addPhoneNumber &&
                  !donePage,
            ),
            ProgressIconLoginWidget(
              status: LoginStatusEnum.verifyPhoneNumber,
              completed:
                  LoginStatusEnum.verifyPhoneNumber.index <
                      loginState.status.index ||
                  donePage,
              isUsing:
                  loginState.status == LoginStatusEnum.verifyPhoneNumber &&
                  !donePage,
            ),
            ProgressIconLoginWidget(
              status: LoginStatusEnum.done,
              completed: LoginStatusEnum.done.index < loginState.status.index,
              isUsing: loginState.status == LoginStatusEnum.done,
            ),
          ],
        ),
        (donePage)
            ? SizedBox(width: 40, height: 40)
            : IconButtonWidget(
                onTapped: () async {
                  if (loginState.status == LoginStatusEnum.addPhoneNumber ||
                      loginState.status == LoginStatusEnum.verifyPhoneNumber) {
                    print('EXIT TO LOGIN OR SIGNUP');
                    await loginNotifier.exitToLoginOrSignup();
                    return;
                  } else {
                    // On done page, exit to home
                    print('EXIT TO HOME');
                    await loginNotifier.exitToHome();
                    return;
                  }
                },
                path: 'assets/svg/close.svg',
                isActive: true,
              ),
      ],
    );
  }
}
