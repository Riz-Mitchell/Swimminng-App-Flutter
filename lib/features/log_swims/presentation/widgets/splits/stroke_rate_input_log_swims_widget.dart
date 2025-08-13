import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/application/log_split_log_swims_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

final strokeRateProvider = StateProvider<int>((ref) => 0);

class StrokeRateInputLogSwimsWidget extends ConsumerWidget {
  const StrokeRateInputLogSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final strokeRate = ref.watch(strokeRateProvider);

    final strokeRateText = formatTime(strokeRate);

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

            controller: TextEditingController(text: strokeRateText)
              ..selection = TextSelection.collapsed(
                offset: strokeRateText.length,
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
            onChanged: (value) => _onChanged(ref, value),
          ),
        ),
        Text(
          'cyc/min',
          textAlign: TextAlign.center,
          style: textTheme.headlineLarge?.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }

  void _onChanged(WidgetRef ref, String value) {
    ref.read(strokeRateProvider.notifier).state = int.tryParse(value) ?? 0;

    ref.read(logSplitProvider.notifier).updateRate(int.tryParse(value) ?? 0);
  }

  String formatTime(int time) {
    if (time <= 0) {
      return '';
    }
    return time.toString();
  }
}
