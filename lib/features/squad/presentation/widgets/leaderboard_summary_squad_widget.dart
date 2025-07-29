import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/squad/presentation/widgets/leaderboard_summary_item_squad_widget.dart';

class LeaderboardSummarySquadWidget extends ConsumerWidget {
  const LeaderboardSummarySquadWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorScheme.surface,
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Squad Leaderboards',
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  'assets/svg/Return_Icon.svg',
                  width: 25,
                  height: 25,
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaderboardSummaryItemSquadWidget(
                leaderboardName: 'Performances',
                description:
                    'Who in the squad has had the swum closest to their PB',
                asset: 'assets/svg/races.svg',
              ),
              LeaderboardSummaryItemSquadWidget(
                leaderboardName: 'Attendance',
                description: 'Squad attendance for the last 3 months ranked',
                asset: 'assets/svg/rocket.svg',
              ),
              LeaderboardSummaryItemSquadWidget(
                leaderboardName: 'Heart Rate',
                description:
                    'Closest to dying during a set, ranked by heart rate',
                asset: 'assets/svg/heart_rate.svg',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
