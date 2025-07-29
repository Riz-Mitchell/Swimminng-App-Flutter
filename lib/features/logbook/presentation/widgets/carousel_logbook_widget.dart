import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/swim_card_logbook_widget.dart';

class CarouselLogbookWidget extends ConsumerWidget {
  const CarouselLogbookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        enlargeCenterPage: true,
        autoPlay: false,
        enableInfiniteScroll: false,
      ),
      items: [
        SwimCardLogbookWidget(asset: 'assets/svg/Butterfly.svg', swim: null),
        SwimCardLogbookWidget(asset: 'assets/svg/Freestyle.svg', swim: null),
        SwimCardLogbookWidget(asset: 'assets/svg/Backstroke.svg', swim: null),
        SwimCardLogbookWidget(asset: 'assets/svg/Breaststroke.svg', swim: null),
      ],
    );
  }
}
