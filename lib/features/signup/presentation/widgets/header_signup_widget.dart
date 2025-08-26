import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';
import 'package:swimming_app_frontend/features/signup/domain/enum/signup_status_enum.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/progress_icon_signup_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/return_widget.dart';

class HeaderSignupWidget extends ConsumerWidget {
  final bool donePage;

  const HeaderSignupWidget({super.key, this.donePage = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupStatus = ref.watch(signupProvider).status;
    final signupNotifier = ref.read(signupProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (donePage)
            ? SizedBox(width: 40, height: 40)
            : ReturnWidget(
                onTap: () async {
                  await signupNotifier.navigateToPrevStep();
                },
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            ProgressIconSignupWidget(
              status: SignupStatusEnum.initial,
              completed: signupStatus.index > SignupStatusEnum.initial.index,
              isUsing: signupStatus == SignupStatusEnum.initial,
            ),
            ProgressIconSignupWidget(
              status: SignupStatusEnum.addName,
              completed: signupStatus.index > SignupStatusEnum.addName.index,
              isUsing: signupStatus == SignupStatusEnum.addName,
            ),
            ProgressIconSignupWidget(
              status: SignupStatusEnum.addDOB,
              completed: signupStatus.index > SignupStatusEnum.addDOB.index,
              isUsing: signupStatus == SignupStatusEnum.addDOB,
            ),
            ProgressIconSignupWidget(
              status: SignupStatusEnum.addHeight,
              completed: signupStatus.index > SignupStatusEnum.addHeight.index,
              isUsing: signupStatus == SignupStatusEnum.addHeight,
            ),
            ProgressIconSignupWidget(
              status: SignupStatusEnum.addSex,
              completed: signupStatus.index > SignupStatusEnum.addSex.index,
              isUsing: signupStatus == SignupStatusEnum.addSex,
            ),
            ProgressIconSignupWidget(
              status: SignupStatusEnum.addPhoneNumber,
              completed:
                  signupStatus.index > SignupStatusEnum.addPhoneNumber.index,
              isUsing: signupStatus == SignupStatusEnum.addPhoneNumber,
            ),
            ProgressIconSignupWidget(
              status: SignupStatusEnum.verifyPhoneNumber,
              completed:
                  signupStatus.index > SignupStatusEnum.verifyPhoneNumber.index,
              isUsing: signupStatus == SignupStatusEnum.verifyPhoneNumber,
            ),
            ProgressIconSignupWidget(
              status: SignupStatusEnum.done,
              completed: signupStatus.index > SignupStatusEnum.done.index,
              isUsing: signupStatus == SignupStatusEnum.done,
            ),
          ],
        ),
        (donePage)
            ? SizedBox(width: 40, height: 40)
            : IconButtonWidget(
                onTapped: () async {
                  await signupNotifier.exit();
                },
                path: 'assets/svg/close.svg',
                isActive: true,
              ),
      ],
    );
  }
}
