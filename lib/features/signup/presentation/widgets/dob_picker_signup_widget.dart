import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/application/selected_date_signup_provider.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';

class DobPickerSignupWidget extends ConsumerWidget {
  const DobPickerSignupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final selectedDate = ref.watch(selectedDateSignupProvider);

    return SizedBox(
      height: 250,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onBackground,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: selectedDate,
          maximumDate: DateTime.now(),
          minimumYear: 1900,
          maximumYear: DateTime.now().year,
          onDateTimeChanged: (DateTime newDate) async {
            ref.read(selectedDateSignupProvider.notifier).state = newDate;
            await ref
                .read(signupProvider.notifier)
                .updateSignupForm(dateOfBirth: newDate.toUtc());
          },
        ),
      ),
    );
  }
}
