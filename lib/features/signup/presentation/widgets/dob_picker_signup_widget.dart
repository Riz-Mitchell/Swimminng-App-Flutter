import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/application/providers/form/signup_form_provider.dart';

class DobPickerSignupWidget extends ConsumerStatefulWidget {
  const DobPickerSignupWidget({super.key});

  @override
  ConsumerState<DobPickerSignupWidget> createState() => _DOBPickerState();
}

class _DOBPickerState extends ConsumerState<DobPickerSignupWidget> {
  DateTime selectedDate = DateTime.now();

  void _showDatePicker(BuildContext context) {
    final signupFormNotifier = ref.read(signupFormProvider.notifier);

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: selectedDate,
          maximumDate: DateTime.now(),
          minimumYear: 1900,
          maximumYear: DateTime.now().year,
          onDateTimeChanged: (DateTime newDate) {
            setState(() {
              selectedDate = newDate;
            });
            signupFormNotifier.updateDateOfBirth(newDate.toUtc());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date of Birth',
              style: textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
