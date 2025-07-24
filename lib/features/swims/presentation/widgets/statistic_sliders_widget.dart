import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/swims/enum/metric_type_enum.dart';
import 'package:swimming_app_frontend/features/swims/presentation/widgets/stat_bar_widget.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/selected_metric_provider.dart';
import 'package:swimming_app_frontend/features/swims/application/providers/swim_graph_provider.dart';

class StatisticSlidersWidget extends ConsumerWidget {
  const StatisticSlidersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('Statistic Sliders Page Unimplemented'));
    // final swimGraph = ref.watch(swimGraphControllerProvider);
    // final swimGraphNotifier = ref.read(swimGraphControllerProvider.notifier);

    // final pbTime = swimGraphNotifier.getAverageY(MetricType.pbTime);
    // final pbRate = swimGraphNotifier.getAverageY(MetricType.pbRate);
    // final goalTime = swimGraphNotifier.getAverageY(MetricType.goalTime);
    // final goalRate = swimGraphNotifier.getAverageY(MetricType.goalRate);

    // return Container(
    //   child: Column(
    //     spacing: 10,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Container(
    //         padding: EdgeInsets.symmetric(horizontal: 10),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Container(
    //               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //               decoration: BoxDecoration(
    //                 color: Colors.blue[100],
    //                 borderRadius: BorderRadius.circular(5),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 spacing: 5,
    //                 children: [
    //                   RotatedBox(
    //                     quarterTurns: 2,
    //                     child: SvgPicture.asset(
    //                       colorFilter: ColorFilter.mode(
    //                         Colors.blue,
    //                         BlendMode.srcIn,
    //                       ),
    //                       'assets/svg/Arrow.svg',
    //                       width: 15,
    //                       height: 15,
    //                     ),
    //                   ),
    //                   Text(
    //                     'Good',
    //                     style: TextTheme.of(
    //                       context,
    //                     ).displayMedium!.copyWith(color: Colors.blue),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Text(
    //               '% Off',
    //               style: TextTheme.of(context).displayMedium!.copyWith(
    //                 color: Theme.of(context).colorScheme.primary,
    //               ),
    //             ),
    //             Container(
    //               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //               decoration: BoxDecoration(
    //                 color: Colors.orange[200],
    //                 borderRadius: BorderRadius.circular(5),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 spacing: 5,
    //                 children: [
    //                   Text(
    //                     'Bad',
    //                     style: TextTheme.of(
    //                       context,
    //                     ).displayMedium!.copyWith(color: Colors.orange),
    //                   ),
    //                   SvgPicture.asset(
    //                     colorFilter: ColorFilter.mode(
    //                       Colors.orange,
    //                       BlendMode.srcIn,
    //                     ),
    //                     'assets/svg/Arrow.svg',
    //                     width: 15,
    //                     height: 15,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Column(
    //         spacing: 10,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           GestureDetector(
    //             onTap: () => ref.read(selectedMetricProvider.notifier).state =
    //                 MetricType.pbTime,
    //             child: StatBarWidget(title: 'PB Time', value: pbTime, max: 15),
    //           ),
    //           GestureDetector(
    //             onTap: () => ref.read(selectedMetricProvider.notifier).state =
    //                 MetricType.pbRate,
    //             child: StatBarWidget(title: 'PB Rate', value: pbRate, max: 15),
    //           ),
    //           GestureDetector(
    //             onTap: () => ref.read(selectedMetricProvider.notifier).state =
    //                 MetricType.goalTime,
    //             child: StatBarWidget(
    //               title: 'Goal Time',
    //               value: goalTime,
    //               max: 15,
    //             ),
    //           ),
    //           GestureDetector(
    //             onTap: () => ref.read(selectedMetricProvider.notifier).state =
    //                 MetricType.goalTime,
    //             child: StatBarWidget(
    //               title: 'Goal Rate',
    //               value: goalRate,
    //               max: 15,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
