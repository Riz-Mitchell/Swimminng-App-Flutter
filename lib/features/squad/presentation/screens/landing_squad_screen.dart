import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/squad/presentation/widgets/basic_card_squad_widget.dart';
import 'package:swimming_app_frontend/features/squad/presentation/widgets/leaderboard_summary_squad_widget.dart';
import 'package:swimming_app_frontend/features/squad/presentation/widgets/session_summary_squad_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class LandingSquadScreen extends ConsumerWidget {
  const LandingSquadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 50,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          spacing: 25,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButtonWidget(path: 'assets/svg/search.svg'),
            IconButtonWidget(path: 'assets/svg/gear.svg'),
          ],
        ),
        BasicCardSquadWidget(),
        LeaderboardSummarySquadWidget(),
        SessionSummarySquadWidget(),
      ],
    );
  }
}
