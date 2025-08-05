import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/swim_card_logbook_widget.dart';

class CarouselLogbookWidget extends ConsumerWidget {
  const CarouselLogbookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
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
                'Swipe For Today\'s Swims',
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              SvgPicture.asset(
                'assets/svg/swipe.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
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
            SwimCardLogbookWidget(
              asset: 'assets/svg/Butterfly.svg',
              swim: null,
            ),
            SwimCardLogbookWidget(
              asset: 'assets/svg/Freestyle.svg',
              swim: null,
            ),
            SwimCardLogbookWidget(
              asset: 'assets/svg/Backstroke.svg',
              swim: null,
            ),
            SwimCardLogbookWidget(
              asset: 'assets/svg/Breaststroke.svg',
              swim: null,
            ),
          ],
        ),
      ],
    );
  }
}
