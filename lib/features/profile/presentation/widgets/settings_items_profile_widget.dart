import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swimming_app_frontend/features/profile/domain/enum/profile_editing_type_enum.dart';
import 'package:swimming_app_frontend/features/profile/domain/models/profile_model.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class SettingsItemsProfileWidget extends ConsumerWidget {
  final ProfileModel currentProfile;

  const SettingsItemsProfileWidget({super.key, required this.currentProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    const titleFlex = 1;
    const valueFlex = 3;

    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            print('going to edit name');
            ref
                .read(routerProvider)
                .push('/edit-user-field', extra: ProfileEditingTypeEnum.name);
          },
          child: Row(
            children: [
              Expanded(
                flex: titleFlex, // first item takes 2 parts
                child: Text(
                  'Name',
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
              Expanded(
                flex: valueFlex, // second item takes 3 parts
                child: Text(
                  '${currentProfile.user.name}',
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
              RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  'assets/svg/Return_Icon.svg',
                  width: 40,
                  height: 40,
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: colorScheme.secondary,
          thickness: 1,
          radius: BorderRadius.circular(20),
        ),
        Row(
          children: [
            Expanded(
              flex: titleFlex,
              child: Text(
                'Age',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                '${currentProfile.user.age}',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                'assets/svg/Return_Icon.svg',
                width: 40,
                height: 40,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: colorScheme.secondary,
          thickness: 1,
          radius: BorderRadius.circular(20),
        ),
        Row(
          children: [
            Expanded(
              flex: titleFlex,
              child: Text(
                'Gender',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
            Expanded(
              flex: valueFlex,
              child: Text(
                'Male',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                'assets/svg/Return_Icon.svg',
                width: 40,
                height: 40,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: colorScheme.secondary,
          thickness: 1,
          radius: BorderRadius.circular(20),
        ),

        Row(
          children: [
            Expanded(
              flex: titleFlex,
              child: Text(
                'Height',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
            Expanded(
              flex: valueFlex,
              child: Text(
                '${currentProfile.user.height} cm',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                'assets/svg/Return_Icon.svg',
                width: 40,
                height: 40,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: colorScheme.secondary,
          thickness: 1,
          radius: BorderRadius.circular(20),
        ),
      ],
    );
  }
}
