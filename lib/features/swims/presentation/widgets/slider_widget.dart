// import 'package:animated_toggle_switch/animated_toggle_switch.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:swimming_app_frontend/shared/presentation/extensions/custom_theme.dart';

// enum SliderOption { overview, vs, breakdown }

// extension SliderLabel on SliderOption {
//   String get label {
//     switch (this) {
//       case SliderOption.overview:
//         return 'Overview';
//       case SliderOption.vs:
//         return 'Vs';
//       case SliderOption.breakdown:
//         return 'Breakdown';
//     }
//   }
// }

// final sliderOptionProvider = StateProvider<SliderOption>((ref) {
//   return SliderOption.overview;
// });

// class SliderWidget extends ConsumerWidget {
//   const SliderWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentOption = ref.watch(sliderOptionProvider);
//     final notifier = ref.read(sliderOptionProvider.notifier);
//     final sliderValues = SliderOption.values;

//     final belowCardColor =
//         Theme.of(context).extension<CustomColors>()?.belowCard ?? Colors.grey;

//     return AnimatedToggleSwitch<SliderOption>.size(
//       textDirection: TextDirection.rtl,
//       current: currentOption,
//       values: sliderValues,
//       iconOpacity: 0.2,
//       indicatorSize: const Size.fromWidth(100),
//       iconBuilder:

//       borderWidth: 4.0,
//       iconAnimationType: AnimationType.onHover,
//       style: ToggleStyle(
//         borderColor: Colors.transparent,
//         borderRadius: BorderRadius.circular(10.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             spreadRadius: 1,
//             blurRadius: 2,
//             offset: Offset(0, 1.5),
//           ),
//         ],
//       ),
//       styleBuilder: (i) =>
//           ToggleStyle(indicatorColor: Theme.of(context).colorScheme.surface),
//       onChanged: (value) => notifier.state = value,
//     );
//   }
// }
