import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/signup/domain/enum/signup_status_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class ProgressIconSignupWidget extends ConsumerWidget {
  final bool completed;
  final bool isUsing;
  final SignupStatusEnum status;

  const ProgressIconSignupWidget({
    super.key,
    required this.completed,
    this.isUsing = false,
    required this.status,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (completed) {
      return Icon(Icons.circle, size: 12, color: metricBlue);
    } else if (isUsing) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: metricBlue, // Circle border color
            width: 2,
          ),
        ),
        child: _getStatusIcon(colorScheme),
      );
    } else {
      return Icon(Icons.circle, size: 12, color: colorScheme.secondary);
    }
  }

  Widget _getStatusIcon(ColorScheme colorScheme) {
    String assetPath;
    switch (status) {
      case SignupStatusEnum.initial:
        assetPath = 'assets/svg/check_list.svg';
        break;
      case SignupStatusEnum.addName:
        assetPath = 'assets/svg/id_card.svg';
        break;
      case SignupStatusEnum.addDOB:
        assetPath = 'assets/svg/cake.svg';
        break;
      case SignupStatusEnum.addHeight:
        assetPath = 'assets/svg/ruler.svg';
        break;
      case SignupStatusEnum.addSex:
        assetPath = 'assets/svg/stars.svg';
        break;
      case SignupStatusEnum.addPhoneNumber:
        assetPath = 'assets/svg/smart_phone.svg';
        break;
      case SignupStatusEnum.verifyPhoneNumber:
        assetPath = 'assets/svg/shield.svg';
        break;
      case SignupStatusEnum.done:
        assetPath = 'assets/svg/tick.svg';
        break;
    }
    return SvgPicture.asset(
      assetPath,
      width: 40,
      height: 40,
      colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
    );
  }
}
