import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/presentation/widgets/distance_card_widget.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/event_selection_provider.dart.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/navigation/add_swim_navigation_provider.dart';
import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/return_widget.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';

class SelectEventDistanceScreen extends ConsumerWidget {
  const SelectEventDistanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Placeholder();
    // final eventSelectionState = ref.watch(eventSelectionProvider);
    // final eventSelectionNotifier = ref.read(eventSelectionProvider.notifier);
    // final isValid = eventSelectionNotifier.isValidSelection();

    // // final Stroke? eventStroke = eventSelectionNotifier.getStroke();

    // return Stack(
    //   children: [
    //     Scaffold(
    //       resizeToAvoidBottomInset: false,
    //       backgroundColor: Theme.of(context).colorScheme.background,
    //       body: Container(
    //         margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
    //         child: SingleChildScrollView(
    //           child: Column(
    //             spacing: 20,
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               ReturnWidget(
    //                 onTap: () {
    //                   // eventSelectionNotifier.handleReturnToSelectEventPage();
    //                   ref.read(routerProvider).go('/add-swim-select-event');
    //                 },
    //               ),
    //               Text('Select Distance'),
    //               Wrap(
    //                 spacing: 20,
    //                 runSpacing: 20,
    //                 children: _getDistancesForStroke(eventStroke)
    //                     .map(
    //                       (distance) => DistanceCardWidget(distance: distance),
    //                     )
    //                     .toList(),
    //               ),
    //               ButtonWidget(
    //                 text: 'Next',
    //                 onPressed: () =>
    //                     ref.read(addSwimNavigationProvider.notifier).next(),
    //                 active: isValid,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  List<int> _getDistancesForStroke(Stroke? stroke) {
    switch (stroke) {
      case Stroke.freestyle:
        return [50, 100, 200, 400, 800, 1500];
      case Stroke.backstroke:
      case Stroke.breaststroke:
      case Stroke.butterfly:
        return [100, 200];
      default:
        return [200, 400];
    }
  }
}
