import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/login_shell_screen.dart';
import 'package:swimming_app_frontend/features/signup/application/selected_date_signup_provider.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/dob_picker_signup_widget.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/header_signup_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class DateOfBirthSignupScreen extends ConsumerWidget {
  const DateOfBirthSignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = DateTime(
      ref.watch(selectedYearProvider),
      ref.watch(selectedMonthProvider),
      ref.watch(selectedDayProvider),
    );
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return LoginShellScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderSignupWidget(),
          const SizedBox(height: 100),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'What\'s your date of birth?',
              style: textTheme.headlineLarge?.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
          ),
          DobPickerSignupWidget(),
          Divider(color: colorScheme.secondary),
          Text(
            'Age ${_getAgeString(selectedDate)}',
            style: textTheme.headlineLarge?.copyWith(
              color: colorScheme.onBackground,
            ),
          ),
          Text(
            'This can be changed later.',
            style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary),
          ),
          SizedBox(height: 100),
          MetricButtonWidget(
            text: 'Next',
            isEnabled: true,
            onPressed: () async {
              await ref.read(signupProvider.notifier).navigateToNextStep();
            },
          ),
        ],
      ),
    );
  }

  String _getAgeString(DateTime date) {
    final currentDate = DateTime.now();
    int age = currentDate.year - date.year;
    if (currentDate.month < date.month ||
        (currentDate.month == date.month && currentDate.day < date.day)) {
      age--;
    }
    return age.toString();
  }
}
