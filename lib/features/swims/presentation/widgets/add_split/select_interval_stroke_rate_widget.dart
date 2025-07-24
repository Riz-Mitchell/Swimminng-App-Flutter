import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/form/add_split_form.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/form/add_swim_form.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/navigation/add_split_navigation_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/button_widget.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);
final List<int> strokeRates = List.generate(61, (index) => 20 + index);

class SelectIntervalStrokeRateWidget extends ConsumerWidget {
  const SelectIntervalStrokeRateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addSwimFormState = ref.read(addSwimFormProvider);
    final addSwimFormNotifier = ref.read(addSwimFormProvider.notifier);

    final addSplitState = ref.watch(addSplitNavigationProvider);
    final addSplitNotifier = ref.read(addSplitNavigationProvider.notifier);

    final addSplitForm = ref.watch(addSplitFormProvider);
    final addSplitFormNotifier = ref.watch(addSplitFormProvider.notifier);

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
              'Split stroke rate',
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
            children: strokeRates
                .map((rate) => Center(child: Text('${rate} cyc/min')))
                .toList(),
          ),
        ),
        ButtonWidget(
          text: 'Complete',
          onPressed: () {
            ref
                .read(addSplitFormProvider.notifier)
                .updateStrokeRate(strokeRates[selectedIndex]);
            final shouldClose = addSplitNotifier.nextStep();
            if (shouldClose) Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
