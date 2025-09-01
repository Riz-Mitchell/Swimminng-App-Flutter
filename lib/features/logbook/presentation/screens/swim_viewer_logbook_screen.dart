import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/log_swims_shell_screen.dart';
import 'package:swimming_app_frontend/features/logbook/application/logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/application/viewing_swim_logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/viewing_swim_model.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/radial_guage_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/split_selector_logbook_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/swim_viewer_graph_logbook_widget.dart';
import 'package:swimming_app_frontend/providers/swim_service_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class SwimViewerLogbookScreen extends ConsumerWidget {
  const SwimViewerLogbookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    final viewingSwimState = ref.watch(viewingSwimLogbookProvider);

    return LogSwimsShellScreen(
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButtonWidget(
                    path: 'assets/svg/close.svg',
                    onTapped: () => ref.read(routerProvider).pop('/home'),
                    overrideColor: colorScheme.primary,
                    size: 25,
                  ),
                  Text(
                    viewingSwimState.swim!.event.toReadableString(),
                    style: textTheme.headlineSmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  IconButtonWidget(
                    path: 'assets/svg/gear.svg',
                    overrideColor: colorScheme.primary,
                    onTapped: () => _handleSettingsTapped(
                      context,
                      ref,
                      colorScheme,
                      viewingSwimState,
                    ),
                  ),
                ],
              ),
              SplitSelectorLogbookWidget(),
            ],
          ),
          SizedBox(height: 40),
          RadialGaugeLogbookWidget(split: viewingSwimState.selectedSplit),
          SizedBox(height: 30),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Velocity Graph',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              SvgPicture.asset(
                'assets/svg/swimmer_icon.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(
                  colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SwimViewerGraphLogbookWidget(
            swim: viewingSwimState.swim!,
            selectedSplit: viewingSwimState.selectedSplit!,
          ),
          SizedBox(height: 200),
        ],
      ),
    );
  }

  void _handleSettingsTapped(
    BuildContext context,
    WidgetRef ref,
    ColorScheme colorScheme,
    ViewingSwimModel viewingSwimState,
  ) {
    showModalBottomSheet(
      context: rootNavigatorKey.currentContext!,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque, // ✅ allows taps on empty space
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: colorScheme.secondary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 12,
                          right: 12,
                          bottom: 40,
                        ),
                        child: Column(
                          spacing: 40,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MetricButtonWidget(
                              text: 'Edit Swim',
                              onPressed: () {
                                print('Editing Swim...');
                              },
                            ),
                            MetricButtonWidget(
                              text: 'Delete Swim',
                              onPressed: () async {
                                print('Deleting Swim...');
                                await ref
                                    .read(swimServiceProvider)
                                    .deleteSwim(viewingSwimState.swim!.id);

                                await ref
                                    .read(logbookProvider.notifier)
                                    .handleDeleteSwim(
                                      viewingSwimState.swim!.recordedAt,
                                    );

                                ref.read(routerProvider).go('/home');
                              },
                              metricColor: metricRed,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
