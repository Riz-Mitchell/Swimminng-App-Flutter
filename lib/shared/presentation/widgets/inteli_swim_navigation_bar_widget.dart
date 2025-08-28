import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/home/domain/home_page_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/nav_icon_widget.dart';

class InteliSwimNavigationBarWidget extends ConsumerWidget {
  const InteliSwimNavigationBarWidget({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 90,
      padding: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavIconWidget(
            asset: 'assets/svg/book.svg',
            selectedAsset: 'assets/svg/book_full.svg',
            pageItem: HomePageEnum.logbook,
          ),
          // NavIconWidget(
          //   asset: 'assets/svg/scatter_plot.svg',
          //   pageItem: HomePageEnum.statistics,
          // ),
          NavIconWidget(
            asset: 'assets/svg/group.svg',
            selectedAsset: 'assets/svg/group_full.svg',
            pageItem: HomePageEnum.squad,
          ),
          NavIconWidget(
            asset: 'assets/svg/user_placeholder.svg',
            selectedAsset: 'assets/svg/user_placeholder_full.svg',
            pageItem: HomePageEnum.profile,
          ),
        ],
      ),
    );
  }
}
