import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumInputWidget extends ConsumerWidget {
  final void Function(String) onChanged;

  const PhoneNumInputWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IntlPhoneField(
      initialCountryCode: 'AU', // Change as needed
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2, // thicker when focused
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      initialValue: '',
      onChanged: (phone) async {
        onChanged(phone.completeNumber);
      },
      onCountryChanged: (country) {
        debugPrint('Country changed to: ${country.name}');
      },
      invalidNumberMessage: 'Invalid phone number',
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
