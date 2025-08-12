import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/time_input_type_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

final minutesProvider = StateProvider<String>((ref) => '');
final secondsProvider = StateProvider<String>((ref) => '');
final hundredthsProvider = StateProvider<String>((ref) => '');

class TimeInputLogSwimsWidget extends ConsumerWidget {
  final TimeInputTypeEnum timeInputType;
  final String subscriptText;

  const TimeInputLogSwimsWidget({
    super.key,
    required this.timeInputType,
    this.subscriptText = '',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final minutesText = ref.watch(minutesProvider);
    final secondsText = ref.watch(secondsProvider);
    final hundredthsText = ref.watch(hundredthsProvider);

    return Row(
      textBaseline: TextBaseline.alphabetic,
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80, // fixed width to fit input nicely
          child: TextField(
            cursorColor: metricBlue,
            textAlign: TextAlign.right,
            textDirection: TextDirection.ltr,
            controller:
                TextEditingController(
                    text: switch (timeInputType) {
                      TimeInputTypeEnum.minutes => formatTime(minutesText),
                      TimeInputTypeEnum.seconds => formatTime(secondsText),
                      TimeInputTypeEnum.hundredths => formatTime(
                        hundredthsText,
                      ),
                    },
                  )
                  ..selection = TextSelection.collapsed(
                    offset: switch (timeInputType) {
                      TimeInputTypeEnum.minutes => minutesText.length,
                      TimeInputTypeEnum.seconds => secondsText.length,
                      TimeInputTypeEnum.hundredths => hundredthsText.length,
                    },
                  ),
            keyboardType: const TextInputType.numberWithOptions(),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 2,
            style: textTheme.displayLarge?.copyWith(
              color: colorScheme.onPrimary,
            ),
            decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: '00',
              hintStyle: textTheme.displayLarge?.copyWith(
                color: colorScheme.secondary,
              ),
            ),
            onChanged: (value) => switch (timeInputType) {
              TimeInputTypeEnum.minutes =>
                ref.read(minutesProvider.notifier).state = value,
              TimeInputTypeEnum.seconds =>
                ref.read(secondsProvider.notifier).state = value,
              TimeInputTypeEnum.hundredths =>
                ref.read(hundredthsProvider.notifier).state = value,
            },
          ),
        ),
        Text(
          subscriptText,
          textAlign: TextAlign.center,
          style: (subscriptText == '.')
              ? textTheme.displayLarge?.copyWith(color: colorScheme.onPrimary)
              : textTheme.headlineLarge?.copyWith(color: colorScheme.onPrimary),
        ),
      ],
    );
  }

  String formatTime(String value) {
    // if (value.isEmpty) return '';
    // if (value.length == 1) return '0$value';
    return value;
  }
}
