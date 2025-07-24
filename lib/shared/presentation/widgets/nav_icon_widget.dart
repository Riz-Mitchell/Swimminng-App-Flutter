import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/inteli_swim_navigation_bar_widget.dart';

class NavIconWidget extends ConsumerWidget {
  final String asset;
  final NavigationItem pageItem;

  const NavIconWidget({super.key, required this.asset, required this.pageItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentItem = ref.watch(navigationItemProvider);
    final colorScheme = Theme.of(context).colorScheme;

    final navItemNotifier = ref.read(navigationItemProvider.notifier);

    final isSelected = currentItem == pageItem;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: SvgPicture.asset(
              asset,
              key: ValueKey(isSelected),
              height: 30,
              width: 30,
              colorFilter: ColorFilter.mode(
                isSelected ? colorScheme.primary : colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        onTap: () => _handleTap(currentItem, ref),
      ),
    );
  }

  void _handleTap(NavigationItem currentItem, WidgetRef ref) {
    if (currentItem == pageItem) return; // No action if already selected

    ref.read(navigationItemProvider.notifier).state = pageItem;

    switch (pageItem) {
      case NavigationItem.logbook:
        ref.read(routerProvider).go('/logbook-landing');
        print('Navigating to logbook');
        break;
      case NavigationItem.statistics:
        // ref.read(routerProvider).go('/statistics');
        print('Navigating to statistics');
        break;
      case NavigationItem.social:
        // ref.read(routerProvider).go('/social');
        print('Navigating to social');
        break;
      case NavigationItem.profile:
        // ref.read(routerProvider).go('/profile');
        print('Navigating to profile');
        break;
    }
  }
}
