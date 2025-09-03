import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class VerifyWidget extends ConsumerWidget {
  final Function(String) onCompleted;

  const VerifyWidget({super.key, required this.onCompleted});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Pinput(
      length: 6,
      defaultPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.primary),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.primary, // 👈 bottom border color
              width: 1, // 👈 border thickness
            ),
          ),
        ),
      ),
      onCompleted: (code) async => onCompleted(code),
    );
  }
}
