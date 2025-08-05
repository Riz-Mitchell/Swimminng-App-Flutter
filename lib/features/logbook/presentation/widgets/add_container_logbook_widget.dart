import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/widgets/add_child_logbook_widget.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/data_profile_widget.dart';

class AddContainerLogbookWidget extends ConsumerWidget {
  const AddContainerLogbookWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Log Something',
                  style: textTheme.headlineMedium?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                SvgPicture.asset(
                  'assets/svg/book.svg',
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
          // Place the add buttons here
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Expanded(
                  child: AddChildLogbookWidget(
                    text: 'Swim',
                    asset: 'assets/svg/swimmer_icon.svg',
                  ),
                ),
                Expanded(
                  child: AddChildLogbookWidget(
                    text: 'Check In',
                    asset: 'assets/svg/clip_board.svg',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
