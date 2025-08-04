import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/data_container_profile_widget.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/carousel_profile_widget.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/header_profile_widget.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/stroke_distribution_radar_profile_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class LandingProfileScreen extends ConsumerWidget {
  const LandingProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      spacing: 50,
      children: [
        HeaderProfileWidget(
          name: 'Rizzle',
          swims: 1450,
          joinedDate: DateTime(2025, 1, 1),
          friends: 231,
        ),
        // StrokeDistributionRadarProfileWidget(),
        CarouselProfileWidget(),

        DataContainerProfileWidget(),
      ],
    );
  }
}
