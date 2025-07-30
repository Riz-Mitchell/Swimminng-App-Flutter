import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/pb_card_profile_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class CarouselProfileWidget extends ConsumerWidget {
  const CarouselProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Personal Bests',
                  style: textTheme.headlineMedium?.copyWith(
                    color: metricPurple,
                  ),
                ),
                SvgPicture.asset(
                  'assets/svg/personal_best.svg',
                  width: 25,
                  height: 25,
                  colorFilter: ColorFilter.mode(metricPurple, BlendMode.srcIn),
                ),
              ],
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: true,
              autoPlay: false,
              enableInfiniteScroll: false,
            ),
            items: [
              PbCardProfileWidget(
                asset: 'assets/svg/Butterfly.svg',
                swim: null,
              ),
              PbCardProfileWidget(
                asset: 'assets/svg/Freestyle.svg',
                swim: null,
              ),
              PbCardProfileWidget(
                asset: 'assets/svg/Backstroke.svg',
                swim: null,
              ),
              PbCardProfileWidget(
                asset: 'assets/svg/Breaststroke.svg',
                swim: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
