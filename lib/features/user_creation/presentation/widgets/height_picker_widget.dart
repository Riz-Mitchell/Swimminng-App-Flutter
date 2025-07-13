import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/form/signup_form_provider.dart';

class HeightPickerWidget extends ConsumerStatefulWidget {
  const HeightPickerWidget({super.key});

  @override
  ConsumerState<HeightPickerWidget> createState() => _HeightPickerState();
}

class _HeightPickerState extends ConsumerState<HeightPickerWidget> {
  int selectedIndex = 50; // index for 150cm (e.g. 100 + 50)

  List<double> get heightOptions =>
      List.generate(151, (index) => 100.0 + index); // 100.0cm to 250.0cm

  void _showHeightPicker(BuildContext context) {
    final signupForm = ref.watch(signupFormProvider);
    final signupFormNotifier = ref.read(signupFormProvider.notifier);

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem: selectedIndex,
                ),
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });

                  // Update height in Riverpod state
                  signupFormNotifier.updateHeight(heightOptions[index]);
                },
                children: heightOptions
                    .map(
                      (height) => Center(
                        child: Text('${height.toStringAsFixed(1)} cm'),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final height = ref.watch(signupFormProvider).height;

    return GestureDetector(
      onTap: () => _showHeightPicker(context),
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
              'Height',
              style: textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              height != null
                  ? '${height.toStringAsFixed(1)} cm'
                  : 'Tap to select',
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
