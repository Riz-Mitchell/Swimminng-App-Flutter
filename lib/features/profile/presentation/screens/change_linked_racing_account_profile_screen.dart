import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/external/aus/application/link_external_swims_provider.dart';
import 'package:swimming_app_frontend/features/link_external_swims/domain/models/link_external_swims_model.dart';
import 'package:swimming_app_frontend/features/profile/application/profile_provider.dart';
import 'package:swimming_app_frontend/features/profile/domain/models/profile_model.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/external_swimmer_search_bar_widget.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/most_recent_swim_card_widget.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/enum/status_card_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/screens/main_shell_screen.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/primary_button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/status_card_widget.dart';

class ChangeLinkedRacingAccountProfileScreen extends ConsumerWidget {
  const ChangeLinkedRacingAccountProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final linkExternalSwimsState = ref.watch(linkExternalSwimsProvider);

    final profileInfo = ref.watch(profileProvider);

    return profileInfo.when(
      error: (error, stackTrace) => StatusCardWidget(
        statusMessage: 'There is an issue with race tracking',
        statusType: StatusCardEnum.error,
      ),
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
            SizedBox(height: 20),
            _getMainBody(profileInfo, linkExternalSwimsState, ref, textTheme),
          ],
        ),
      ),
    );
  }

  Widget _getMainBody(
    ProfileModel profileInfo,
    AsyncValue<LinkExternalSwimsModel> linkExternalSwimsState,
    WidgetRef ref,
    TextTheme textTheme,
  ) {
    if (profileInfo.user.externalSourceUserId == null) {
      return Column(
        children: [
          ExternalSwimmerSearchBarWidget(),
          SizedBox(height: 40),
          StatusCardWidget(
            statusMessage:
                'You are not currently tracking a swimmer. Please link one',
            statusType: StatusCardEnum.warning,
          ),
          SizedBox(height: 40),
          ..._getMostRecentSwim(linkExternalSwimsState, ref, true, textTheme),
        ],
      );
    } else {
      return Column(
        children: [
          ..._getMostRecentSwim(linkExternalSwimsState, ref, false, textTheme),
          SizedBox(height: 40),
          StatusCardWidget(
            statusMessage: 'Race tracking operating successfully',
            statusType: StatusCardEnum.success,
          ),
        ],
      );
    }
  }

  List<Widget> _getMostRecentSwim(
    AsyncValue<LinkExternalSwimsModel> state,
    WidgetRef ref,
    bool notSet,
    TextTheme textTheme,
  ) {
    return state.when(
      data: (data) {
        if (data.swimsToLink.isEmpty) {
          return [SizedBox.shrink()];
        }
        final swim = data.swimsToLink.first;

        if (notSet) {
          print('not set');
          return [
            MostRecentSwimCardWidget(externalSwim: swim),
            SizedBox(height: 20),
            PrimaryButtonWidget(
              overrideStyle: textTheme.headlineSmall?.copyWith(
                color: metricBlue,
              ),
              overrideBgColor: Colors.transparent,
              text: 'Update Tracked Swimmer',
              onPressed: () async => await ref
                  .read(profileProvider.notifier)
                  .updateUserAsync(
                    externalSourceUserId: (data.selectedSwimmer != null)
                        ? data.selectedSwimmer!.participantId
                        : null,
                  ),
            ),
          ];
        }

        return [MostRecentSwimCardWidget(externalSwim: swim)];
      },
      error: (error, stack) => [SizedBox.shrink()],
      loading: () => [SizedBox.shrink()],
    );
  }
}
