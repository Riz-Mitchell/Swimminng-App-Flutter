import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/application/signup_provider.dart';

// Selected unit: 'cm' or 'ft'
final heightUnitProvider = StateProvider<String>((ref) => 'cm');

// Selected cm value
final selectedCmProvider = StateProvider<int>((ref) => 170);

// Selected ft/in values
final selectedFeetProvider = StateProvider<int>((ref) => 5);
final selectedInchesProvider = StateProvider<int>((ref) => 7);

class HeightPickerSignupWidget extends ConsumerWidget {
  const HeightPickerSignupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final height = ref.watch(signupProvider).signupForm.height;

    final unit = ref.watch(heightUnitProvider);
    final cm = ref.watch(selectedCmProvider);
    final feet = ref.watch(selectedFeetProvider);
    final inches = ref.watch(selectedInchesProvider);

    final pickerStyle = textTheme.bodyLarge?.copyWith(
      color: colorScheme.onBackground,
    );

    // Generate lists
    final cmList = List.generate(250, (i) => i + 50); // 50cm to 300cm
    final feetList = List.generate(8, (i) => i + 3); // 3ft to 10ft
    final inchesList = List.generate(12, (i) => i); // 0in to 11in

    return SizedBox(
      height: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 20,
            child: unit == 'cm'
                ? CupertinoPicker(
                    itemExtent: 40,
                    scrollController: FixedExtentScrollController(
                      initialItem: cm - 50,
                    ),
                    onSelectedItemChanged: (index) async {
                      ref.read(selectedCmProvider.notifier).state = index + 50;
                      await updateHeightProviders(ref, changedUnit: 'cm');
                    },
                    children: cmList
                        .map(
                          (c) =>
                              Center(child: Text('$c cm', style: pickerStyle)),
                        )
                        .toList(),
                  )
                : Row(
                    children: [
                      // Feet
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 40,
                          scrollController: FixedExtentScrollController(
                            initialItem: feet - 3,
                          ),
                          onSelectedItemChanged: (index) async {
                            ref.read(selectedFeetProvider.notifier).state =
                                index + 3;
                            await updateHeightProviders(ref, changedUnit: 'ft');
                          },
                          children: feetList
                              .map(
                                (f) => Center(
                                  child: Text('${f}\'', style: pickerStyle),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      // Inches
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 40,
                          scrollController: FixedExtentScrollController(
                            initialItem: inches,
                          ),
                          onSelectedItemChanged: (index) async {
                            ref.read(selectedInchesProvider.notifier).state =
                                index;
                            await updateHeightProviders(ref, changedUnit: 'ft');
                          },
                          children: inchesList
                              .map(
                                (i) => Center(
                                  child: Text('${i}\"', style: pickerStyle),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
          ),
          Expanded(
            flex: 10,
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(
                initialItem: unit == 'cm' ? 0 : 1,
              ),
              onSelectedItemChanged: (index) async {
                final newUnit = index == 0 ? 'cm' : 'ft';
                ref.read(heightUnitProvider.notifier).state = newUnit;
                await updateHeightProviders(ref, changedUnit: newUnit);
              },
              children: [
                Center(child: Text('cm', style: pickerStyle)),
                Center(child: Text('ft/in', style: pickerStyle)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateHeightProviders(
    WidgetRef ref, {
    String? changedUnit,
  }) async {
    final unit = changedUnit ?? ref.read(heightUnitProvider);

    if (unit == 'cm') {
      // If cm changed, update ft/in
      final cm = ref.read(selectedCmProvider);
      final totalInches = cm / 2.54;
      final feet = totalInches ~/ 12;
      final inches = (totalInches % 12).round();

      ref.read(selectedFeetProvider.notifier).state = feet;
      ref.read(selectedInchesProvider.notifier).state = inches;

      print('Height selected: ${cm.roundToDouble()} cm');

      // Update signup form
      await ref
          .read(signupProvider.notifier)
          .updateSignupForm(height: cm.roundToDouble());
    } else {
      // If ft/in changed, update cm
      final feet = ref.read(selectedFeetProvider);
      final inches = ref.read(selectedInchesProvider);
      final cm = ((feet * 12) + inches) * 2.54;

      ref.read(selectedCmProvider.notifier).state = cm.round();

      print('Height selected: ${cm.roundToDouble()} cm');

      // Update signup form
      await ref
          .read(signupProvider.notifier)
          .updateSignupForm(height: cm.roundToDouble());
    }
  }
}
