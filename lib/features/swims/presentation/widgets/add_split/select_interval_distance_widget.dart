import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';
import 'package:swimming_app_frontend/features/swims/domain/models/swim_model.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/form/add_split_form.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/form/add_swim_form.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/navigation/add_split_navigation_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/button_widget.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class SelectIntervalDistanceWidget extends ConsumerWidget {
  const SelectIntervalDistanceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addSwimFormState = ref.read(addSwimFormProvider);
    final addSwimFormNotifier = ref.read(addSwimFormProvider.notifier);

    SplitOptions options;

    print('event: ${addSwimFormState.event}');

    switch (addSwimFormState.event) {
      case EventEnum.freestyle50:
        options = SplitOptions50();
        break;
      case EventEnum.freestyle100:
      case EventEnum.backstroke100:
      case EventEnum.breaststroke100:
      case EventEnum.butterfly100:
        options = SplitOptions100();
        break;
      case EventEnum.freestyle200:
      case EventEnum.backstroke200:
      case EventEnum.breaststroke200:
      case EventEnum.butterfly200:
      case EventEnum.individualMedley200:
        options = SplitOptions200();
        break;
      case EventEnum.freestyle400:
      case EventEnum.individualMedley400:
        options = SplitOptions400();
        break;
      case EventEnum.freestyle800:
        options = SplitOptions800();

        break;
      case EventEnum.freestyle1500:
        options = SplitOptions1500();

        break;
    }

    final addSplitState = ref.watch(addSplitNavigationProvider);
    final addSplitNotifier = ref.read(addSplitNavigationProvider.notifier);

    final selectedIndex = ref.watch(selectedIndexProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BackButton(
              onPressed: () {
                final shouldClose = addSplitNotifier.backStep();
                if (shouldClose) Navigator.pop(context); // close the popup
              },
            ),
            Text(
              'Split distance',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        // put selector here
        SizedBox(
          height: 200,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: selectedIndex,
            ),
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              ref.read(selectedIndexProvider.notifier).state = index;
            },
            children: options.distanceLabels
                .map((o) => Center(child: Text(o)))
                .toList(),
          ),
        ),
        ButtonWidget(
          text: 'Next',
          onPressed: () {
            ref
                .read(addSplitFormProvider.notifier)
                .updateIntervalDistance(options.splitDistances[selectedIndex]);
            final shouldClose = addSplitNotifier.nextStep();
            if (shouldClose) Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
