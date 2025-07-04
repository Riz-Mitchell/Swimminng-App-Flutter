import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:swimming_app_frontend/providers/create_user_provider.dart';

class PhoneNumberInputWidget extends ConsumerWidget {
  const PhoneNumberInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createUserReq = ref.watch(createUserProvider);
    final createUserReqNotifier = ref.read(createUserProvider.notifier);

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
      initialValue: createUserReq.phoneNumber,
      onChanged: (phone) {
        createUserReqNotifier.state = createUserReq.copyWith(
          phoneNumber: phone.completeNumber,
        );
      },
      onCountryChanged: (country) {
        debugPrint('Country changed to: ${country.name}');
      },
      invalidNumberMessage: 'Invalid phone number',
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
