import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/login_user_req_provider.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/post_user_req_provider.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/user_creation_status_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

class VerifyWidget extends ConsumerWidget {
  final Function(String)? onCompleted;

  const VerifyWidget({super.key, this.onCompleted});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCreationStatusNotifier = ref.read(
      userCreationStatusProvider.notifier,
    );
    final postUserReq = ref.watch(postUserReqProvider);
    final loginUserReqNotifier = ref.read(loginUserReqProvider.notifier);
    final userService = ref.read(userServiceProvider);

    return Pinput(
      length: 6,
      onCompleted: (code) async {
        if (onCompleted == null) {
          loginUserReqNotifier.setOTP(code);

          userCreationStatusNotifier.next();
        } else {
          onCompleted!(code);
        }
      },
    );
  }
}
