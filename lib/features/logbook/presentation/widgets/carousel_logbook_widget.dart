import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/logbook/application/logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/application/selected_day_logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/application/selected_swim_logbook_provider.dart';
import 'package:swimming_app_frontend/features/logbook/domain/models/logbook_state_model.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/swim_card_logbook_widget.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';

class CarouselLogbookWidget extends ConsumerWidget {
  const CarouselLogbookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    final carouselController = ref.watch(carouselControllerProvider);
    final selectedIndex = ref.watch(selectedSwimLogbookProvider);
    print('selected index: $selectedIndex');

    final selectedDate = ref.watch(selectedDayLogbookProvider);

    final logbookState = ref.watch(logbookProvider);

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
                style: textTheme.headlineSmall?.copyWith(
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
          carouselController: carouselController,
          options: CarouselOptions(
            initialPage: selectedIndex,
            viewportFraction: 1,
            enlargeCenterPage: true,
            autoPlay: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) =>
                ref.read(selectedSwimLogbookProvider.notifier).setIndex(index),
          ),
          items: [..._buildSwimCards(logbookState, selectedDate)],
        ),
      ],
    );
  }

  List<Widget> _buildSwimCards(
    AsyncValue<LogbookStateModel> logbookState,
    DateTime time,
  ) {
    return logbookState.when(
      data: (data) {
        final dayData = data.getDayData(time.year, time.month, time.day);

        if (dayData == null) {
          return [];
        }

        return dayData.swims.map((swim) {
          return _buildSwimCardWidget(swim);
        }).toList();
      },
      loading: () => [],
      error: (error, stack) => [],
    );
  }

  Widget _buildSwimCardWidget(GetSwimEntity swim) {
    return SwimCardLogbookWidget(swim: swim);
  }
}
