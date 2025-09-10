import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/profile/application/profile_provider.dart';
import 'package:swimming_app_frontend/features/profile/domain/enum/profile_editing_type_enum.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/screens/main_shell_screen.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class EditFieldProfileScreen extends ConsumerWidget {
  final ProfileEditingTypeEnum editingType;

  const EditFieldProfileScreen({super.key, required this.editingType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final profileInfo = ref.watch(profileProvider);

    return profileInfo.when(
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
          ],
        ),
      ),
      loading: () => SizedBox.shrink(),
      error: (error, stackTrace) => SizedBox.shrink(),
    );
  }
}
