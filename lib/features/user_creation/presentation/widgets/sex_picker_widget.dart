import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/api/models/user_model.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/form/signup_form_provider.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/selected_sex_status_provider.dart';

class SexPickerWidget extends ConsumerWidget {
  const SexPickerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSex = ref.watch(selectedSexStatusProvider);
    final selectedSexNotifier = ref.read(selectedSexStatusProvider.notifier);

    final signupFormNotifier = ref.read(signupFormProvider.notifier);
    final signupForm = ref.watch(signupFormProvider);

    Widget buildSexCard(SelectedSexStatus widgetSex, String assetPath) {
      final isSelected = selectedSex == widgetSex;
      return GestureDetector(
        onTap: () {
          if (widgetSex == SelectedSexStatus.male) {
            selectedSexNotifier.selectMan();
          } else {
            selectedSexNotifier.selectWoman();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: SvgPicture.asset(assetPath, height: 100, width: 100),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildSexCard(SelectedSexStatus.male, 'assets/svg/ic--round-man.svg'),
        buildSexCard(
          SelectedSexStatus.female,
          'assets/svg/ic--round-woman.svg',
        ),
      ],
    );
  }
}
