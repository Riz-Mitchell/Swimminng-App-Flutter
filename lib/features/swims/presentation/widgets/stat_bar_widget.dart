import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/shared/presentation/extensions/custom_theme.dart';

class StatBarWidget extends StatelessWidget {
  final double value;
  final double max;
  final double height;
  final String title;

  const StatBarWidget({
    super.key,
    required this.title,
    required this.value,
    required this.max,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (value.abs() / max).clamp(0, 1).toDouble();

    final belowCardColor = Theme.of(
      context,
    ).extension<CustomColors>()?.belowCard;

    final isNegative = value < 0;
    final isZero = value == 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextTheme.of(context).displayMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                (isNegative)
                    ? '${value.toStringAsFixed(2)}%'
                    : '+${value.toStringAsFixed(2)}%',
                style: isZero
                    ? TextTheme.of(context).displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    : (!isNegative)
                    ? TextTheme.of(
                        context,
                      ).displayMedium!.copyWith(color: Colors.orange)
                    : TextTheme.of(
                        context,
                      ).displayMedium!.copyWith(color: Colors.blue),
              ),
            ],
          ),
          Container(
            height: height,
            decoration: BoxDecoration(
              color: belowCardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FractionallySizedBox(
                        alignment: Alignment.centerRight,
                        widthFactor: percentage, // half on the left
                        child: Container(
                          decoration: BoxDecoration(
                            color: isZero
                                ? Theme.of(context).colorScheme.secondary
                                : !isNegative
                                ? Colors.transparent
                                : Colors.blue,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: percentage, // half on the right
                        child: Container(
                          decoration: BoxDecoration(
                            color: isZero
                                ? Theme.of(context).colorScheme.secondary
                                : isNegative
                                ? Colors.transparent
                                : Colors.orange,
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
