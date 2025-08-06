import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ReturnWidget extends ConsumerWidget {
  const ReturnWidget({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!.call();
        }
      },
      child: SvgPicture.asset(
        'assets/svg/Return_Icon.svg',
        height: 40,
        width: 40,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onBackground,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
