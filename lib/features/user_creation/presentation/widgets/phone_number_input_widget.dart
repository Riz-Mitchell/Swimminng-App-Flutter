import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/post_user_req_provider.dart';

class PhoneNumberInputWidget extends ConsumerWidget {
  final void Function(String)? onChanged;

  const PhoneNumberInputWidget({super.key, this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postUserReq = ref.watch(postUserReqProvider);
    final postUserReqNotifier = ref.read(postUserReqProvider.notifier);

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
      initialValue: postUserReq.phoneNumber,
      onChanged: (phone) {
        if (onChanged == null) {
          postUserReqNotifier.updatePhoneNumber(phone.completeNumber);
        } else {
          onChanged!(phone.completeNumber);
        }
      },
      onCountryChanged: (country) {
        debugPrint('Country changed to: ${country.name}');
      },
      invalidNumberMessage: 'Invalid phone number',
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
