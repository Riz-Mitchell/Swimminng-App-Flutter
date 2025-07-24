import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/presentation/widgets/stroke_card_widget.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/event_selection_provider.dart.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/navigation/add_swim_navigation_provider.dart';
import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/button_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/return_widget.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';

class AddEventScreen extends ConsumerWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventSelectionState = ref.watch(eventSelectionProvider);
    final eventSelectionNotifier = ref.read(eventSelectionProvider.notifier);
    final isValid = eventSelectionNotifier.isValidSelection();

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ReturnWidget(
                    onTap: () => ref.read(routerProvider).go('/swims-landing'),
                  ),
                  Text('Add Event'),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      StrokeCardWidget(stroke: Stroke.freestyle),
                      StrokeCardWidget(stroke: Stroke.backstroke),
                      StrokeCardWidget(stroke: Stroke.breaststroke),
                      StrokeCardWidget(stroke: Stroke.butterfly),
                    ],
                  ),
                  ButtonWidget(
                    text: 'Next',
                    onPressed: () =>
                        ref.read(addSwimNavigationProvider.notifier).next(),
                    active: isValid,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
