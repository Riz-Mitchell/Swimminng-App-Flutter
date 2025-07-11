import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/post_user_req_provider.dart';

class DOBPickerWidget extends ConsumerStatefulWidget {
  const DOBPickerWidget({super.key});

  @override
  ConsumerState<DOBPickerWidget> createState() => _DOBPickerState();
}

class _DOBPickerState extends ConsumerState<DOBPickerWidget> {
  DateTime selectedDate = DateTime.now();

  void _showDatePicker(BuildContext context) {
    final postUserReq = ref.watch(postUserReqProvider);
    final postUserReqNotifier = ref.read(postUserReqProvider.notifier);

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
            postUserReqNotifier.updateDateOfBirth(newDate.toUtc());
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
