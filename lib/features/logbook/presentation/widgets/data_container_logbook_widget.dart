import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/data_logbook_widget.dart';

class DataContainerLogbookWidget extends ConsumerWidget {
  const DataContainerLogbookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Expanded(
                child: DataLogbookWidget(
                  data: '72',
                  text: 'Swims Logged',
                  asset: 'assets/svg/swimmer_icon.svg',
                ),
              ),
              Expanded(
                child: DataLogbookWidget(
                  data: '417',
                  text: 'Races',
                  asset: 'assets/svg/races.svg',
                ),
              ),
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Expanded(
                child: DataLogbookWidget(
                  data: '7',
                  text: 'Focuses',
                  asset: 'assets/svg/focuses.svg',
                ),
              ),

              Expanded(
                child: DataLogbookWidget(
                  data: '45',
                  text: 'Pbs',
                  asset: 'assets/svg/rocket.svg',
                ),
              ),
              Expanded(
                child: DataLogbookWidget(
                  data: '5',
                  text: 'Check Ins',
                  asset: 'assets/svg/clip_board.svg',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
