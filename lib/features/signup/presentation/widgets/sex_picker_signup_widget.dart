import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';
import 'package:swimming_app_frontend/features/signup/domain/enum/selected_sex_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class SexPickerSignupWidget extends ConsumerWidget {
  const SexPickerSignupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSexCard(SelectedSexEnum.male, context, ref),
        _buildSexCard(SelectedSexEnum.female, context, ref),
      ],
    );
  }

  Widget _buildSexCard(
    SelectedSexEnum sex,
    BuildContext context,
    WidgetRef ref,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final currentSex = ref.watch(signupProvider).signupForm.sex;

    final isSelected = sex == currentSex;

    final currColor = isSelected ? metricBlue : colorScheme.secondary;

    return GestureDetector(
      onTap: () async => _handleOnTap(ref, sex, currentSex),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: currColor, width: 2),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: textTheme.bodyMedium!.copyWith(color: (currColor)),
          child: Text(_getSexText(sex)),
        ),
      ),
    );
  }

  Future<void> _handleOnTap(
    WidgetRef ref,
    SelectedSexEnum tappedSex,
    SelectedSexEnum currentSex,
  ) async {
    final signupNotifier = ref.read(signupProvider.notifier);

    final newSex = tappedSex == currentSex
        ? SelectedSexEnum.unselected
        : tappedSex;

    await signupNotifier.updateSignupForm(sex: newSex);
  }

  String _getSexText(SelectedSexEnum selectedSex) {
    switch (selectedSex) {
      case SelectedSexEnum.male:
        return 'Male';
      case SelectedSexEnum.female:
        return 'Female';
      case SelectedSexEnum.unselected:
        return '';
    }
  }
}
