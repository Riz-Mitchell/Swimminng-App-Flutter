import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/api/models/user_model.dart';
import 'package:swimming_app_frontend/providers/create_user_provider.dart';
import 'package:swimming_app_frontend/providers/selected_sex_provider.dart';

class SexPickerWidget extends ConsumerWidget {
  const SexPickerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSex = ref.watch(selectedSexProvider);
    final createUserReqProvider = ref.watch(createUserProvider.notifier);
    final createUserReq = ref.watch(createUserProvider);

    Widget buildSexCard(Sex sex, String assetPath) {
      final isSelected = selectedSex == sex;
      return GestureDetector(
        onTap: () {
          createUserReqProvider.state = createUserReq.copyWith(sex: sex);
          ref.read(selectedSexProvider.notifier).state = sex;
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: SvgPicture.asset(assetPath, height: 100, width: 100),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildSexCard(Sex.male, 'assets/svg/ic--round-man.svg'),
        buildSexCard(Sex.female, 'assets/svg/ic--round-woman.svg'),
      ],
    );
  }
}
