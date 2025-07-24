import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/nav_icon_widget.dart';

enum NavigationItem { logbook, statistics, social, profile }

final navigationItemProvider = StateProvider<NavigationItem>((ref) {
  return NavigationItem.profile; // Default navigation item
});

class InteliSwimNavigationBarWidget extends ConsumerWidget {
  const InteliSwimNavigationBarWidget({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    final currentItem = ref.watch(navigationItemProvider);

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
            pageItem: NavigationItem.logbook,
          ),
          NavIconWidget(
            asset: 'assets/svg/scatter_plot.svg',
            pageItem: NavigationItem.statistics,
          ),
          NavIconWidget(
            asset: 'assets/svg/group.svg',
            pageItem: NavigationItem.social,
          ),
          NavIconWidget(
            asset: 'assets/svg/user_placeholder.svg',
            pageItem: NavigationItem.profile,
          ),
        ],
      ),
    );
  }
}
