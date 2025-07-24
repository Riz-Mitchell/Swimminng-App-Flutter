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

final minuteProvider = AutoDisposeStateProvider<int>((ref) => 0);
final secondProvider = AutoDisposeStateProvider<int>((ref) => 0);
final hundredthProvider = AutoDisposeStateProvider<int>((ref) => 0);

class SelectIntervalTimeWidget extends ConsumerWidget {
  const SelectIntervalTimeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Placeholder();
    // final addSwimFormState = ref.read(addSwimFormProvider);
    // final addSwimFormNotifier = ref.read(addSwimFormProvider.notifier);

    // SplitOptions options;

    // print('event: ${addSwimFormState.event}');

    // switch (addSwimFormState.event) {
    //   case EventEnum.freestyle50:
    //     options = SplitOptions50();
    //     break;
    //   case EventEnum.freestyle100:
    //   case EventEnum.backstroke100:
    //   case EventEnum.breaststroke100:
    //   case EventEnum.butterfly100:
    //     options = SplitOptions100();
    //     break;
    //   case EventEnum.freestyle200:
    //   case EventEnum.backstroke200:
    //   case EventEnum.breaststroke200:
    //   case EventEnum.butterfly200:
    //   case EventEnum.individualMedley200:
    //     options = SplitOptions200();
    //     break;
    //   case EventEnum.freestyle400:
    //   case EventEnum.individualMedley400:
    //     options = SplitOptions400();
    //     break;
    //   case EventEnum.freestyle800:
    //     options = SplitOptions800();

    //     break;
    //   case EventEnum.freestyle1500:
    //     options = SplitOptions1500();

    //     break;
    // }

    // final addSplitState = ref.watch(addSplitNavigationProvider);
    // final addSplitNotifier = ref.read(addSplitNavigationProvider.notifier);

    // final addSplitForm = ref.watch(addSplitFormProvider);
    // final addSplitFormNotifier = ref.read(addSplitFormProvider.notifier);

    // final timeRange = options.getTimeRange(addSplitForm.intervalDistance);

    // final fastestTime = timeRange[0]; // in seconds
    // final slowestTime = timeRange[1]; // in seconds

    // print("fastestTime: ${fastestTime}, slowestTime: ${slowestTime}");

    // final fastestSeconds = fastestTime.floor() % 60;
    // final slowestSeconds = slowestTime.floor() % 60;

    // print(
    //   "fastestSeconds: ${fastestSeconds}, slowestSeconds: ${slowestSeconds}",
    // );

    // // Handle edge case where fastest > slowest within a minute
    // final secondsRange = fastestSeconds <= slowestSeconds
    //     ? List.generate(
    //         slowestSeconds - fastestSeconds + 1,
    //         (i) => fastestSeconds + i,
    //       )
    //     : List.generate(
    //         60 - fastestSeconds + slowestSeconds + 1,
    //         (i) => (fastestSeconds + i) % 60,
    //       );

    // final maxMinutes = slowestTime ~/ 60;

    // print('maxMinutes == ${maxMinutes}');

    // final minuteController = FixedExtentScrollController();
    // final secondController = FixedExtentScrollController();
    // final hundredthController = FixedExtentScrollController();

    // final timeInSeconds =
    //     ref.watch(minuteProvider) * 60 +
    //     ref.watch(secondProvider) +
    //     ref.watch(hundredthProvider) * 0.01;

    // print('time in sec: $timeInSeconds');

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         BackButton(
    //           onPressed: () {
    //             final shouldClose = addSplitNotifier.backStep();
    //             if (shouldClose) Navigator.pop(context); // close the popup
    //           },
    //         ),
    //         Text(
    //           'Split time',
    //           style: Theme.of(context).textTheme.displayLarge?.copyWith(
    //             color: Theme.of(context).colorScheme.primary,
    //           ),
    //         ),
    //       ],
    //     ),
    //     // put selector here
    //     SizedBox(
    //       height: 200,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           // Minutes Picker
    //           (maxMinutes != 0)
    //               ? Expanded(
    //                   child: CupertinoPicker(
    //                     scrollController: minuteController,
    //                     itemExtent: 40,
    //                     onSelectedItemChanged: (index) {
    //                       ref.read(minuteProvider.notifier).state = index;
    //                     },
    //                     children: List.generate(
    //                       maxMinutes + 1,
    //                       (index) => Center(child: Text('$index min')),
    //                     ),
    //                   ),
    //                 )
    //               : const SizedBox.shrink(),
    //           // Seconds Picker
    //           Expanded(
    //             child: CupertinoPicker(
    //               scrollController: secondController,
    //               itemExtent: 40,
    //               onSelectedItemChanged: (index) {
    //                 ref.read(secondProvider.notifier).state =
    //                     secondsRange[index];
    //               },
    //               children: secondsRange
    //                   .map((sec) => Center(child: Text('$sec sec')))
    //                   .toList(),
    //             ),
    //           ),
    //           // Hundredths Picker
    //           Expanded(
    //             child: CupertinoPicker(
    //               scrollController: hundredthController,
    //               itemExtent: 40,
    //               onSelectedItemChanged: (index) {
    //                 ref.read(hundredthProvider.notifier).state = index;
    //               },
    //               children: List.generate(
    //                 100,
    //                 (index) => Center(
    //                   child: Text('.${index.toString().padLeft(2, '0')}'),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     ButtonWidget(
    //       text: 'Next',
    //       onPressed: () {
    //         ref
    //             .read(addSplitFormProvider.notifier)
    //             .updateIntervalTime(timeInSeconds);
    //         final shouldClose = addSplitNotifier.nextStep();
    //         if (shouldClose) Navigator.pop(context);
    //       },
    //     ),
    //   ],
    // );
  }
}
