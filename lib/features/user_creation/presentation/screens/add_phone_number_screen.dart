import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/user_creation/presentation/widgets/button_widget.dart';
import 'package:swimming_app_frontend/features/user_creation/presentation/widgets/enter_text_widget.dart';
import 'package:swimming_app_frontend/features/user_creation/presentation/widgets/phone_number_input_widget.dart';

class CreateAccAddPhoneNumber extends ConsumerWidget {
  const CreateAccAddPhoneNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 220, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  spacing: 30,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'What is your phone number?',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ),
                    PhoneNumberInputWidget(),
                  ],
                ),
              ),
              ButtonWidget(text: 'Next'),
            ],
          ),
        ),
      ),
    );
  }
}
