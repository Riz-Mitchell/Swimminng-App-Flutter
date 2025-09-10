import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/profile/application/profile_provider.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/settings_items_profile_widget.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/screens/main_shell_screen.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class SettingsProfileScreen extends ConsumerWidget {
  const SettingsProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final profileInfo = ref.watch(profileProvider);

    return profileInfo.when(
      error: (error, stackTrace) => SizedBox.shrink(),
      loading: () => SizedBox.shrink(),
      data: (profileInfo) => MainShellScreen(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButtonWidget(
                  path: 'assets/svg/close.svg',
                  overrideColor: colorScheme.primary,
                  onTapped: () async => ref.read(routerProvider).pop(),
                ),
              ],
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // Navigate to change profile picture screen
                ref.read(routerProvider).push('/change-pfp');
              },
              child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      border: Border.all(
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: colorScheme.primary,
                        width: 5.0,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/user_placeholder.svg',
                      width: 100,
                      height: 100,
                      colorFilter: ColorFilter.mode(
                        colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Change Profile Picture',
                    style: textTheme.headlineSmall?.copyWith(color: metricBlue),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            Divider(
              color: colorScheme.secondary,
              thickness: 1,
              radius: BorderRadius.circular(20),
            ),
            SettingsItemsProfileWidget(currentProfile: profileInfo),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                // Navigate to change linked racing account screen
                ref.read(routerProvider).push('/change-linked-racing-account');
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/races.svg',
                    width: 100,
                    height: 100,
                    colorFilter: ColorFilter.mode(
                      colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),

                  SizedBox(height: 30),
                  Text(
                    'Change Linked Racing Account',
                    style: textTheme.headlineSmall?.copyWith(color: metricBlue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
