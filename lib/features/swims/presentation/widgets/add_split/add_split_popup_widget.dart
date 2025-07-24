import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/enum/event_enum.dart';
import 'package:swimming_app_frontend/features/swims/presentation/widgets/add_split/select_interval_distance_widget.dart';
import 'package:swimming_app_frontend/features/swims/presentation/widgets/add_split/select_interval_stroke_rate_widget.dart';
import 'package:swimming_app_frontend/features/swims/presentation/widgets/add_split/select_interval_time_widget.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/form/add_split_form.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/form/add_swim_form.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/navigation/add_split_navigation_provider.dart';
import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/button_widget.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class AddSplitPopupWidget extends ConsumerWidget {
  const AddSplitPopupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addSwimFormState = ref.watch(addSwimFormProvider);
    final addSwimFormNotifier = ref.read(addSwimFormProvider.notifier);
    final Stroke swimStroke = addSwimFormState.event.getStroke();

    return ButtonWidget(
      text: 'Add Split',
      onPressed: () {
        ref.read(addSplitFormProvider.notifier).updateStroke(swimStroke);

        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          builder: (context) => Consumer(
            builder: (context, ref, _) {
              final addSplitState = ref.watch(addSplitNavigationProvider);
              final addSplitNotifier = ref.read(addSplitNavigationProvider);

              return Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                height: 500, // You can adjust height
                child: addSplitState == AddSplitStatus.selectDistance
                    ? SelectIntervalDistanceWidget()
                    : addSplitState == AddSplitStatus.selectTime
                    ? SelectIntervalTimeWidget()
                    : addSplitState == AddSplitStatus.selectStrokeRate
                    ? SelectIntervalStrokeRateWidget()
                    : SelectIntervalStrokeRateWidget(),
                // : AddSplitStatus.selectStrokeCount
                // ? SelectIntervalStrokeCountWidget()
                // : SelectIntervalStrokeCountWidget(),
              );
            },
          ),
        );
      },
    );
  }
}
