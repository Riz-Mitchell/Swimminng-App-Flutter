import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/home/domain/home_page_enum.dart';
import 'package:swimming_app_frontend/features/home/presentation/screens/home_shell_screen.dart';

class NavIconWidget extends ConsumerWidget {
  final String asset;
  final String selectedAsset;
  final HomePageEnum pageItem;

  const NavIconWidget({
    super.key,
    required this.asset,
    required this.selectedAsset,
    required this.pageItem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentItem = ref.watch(currentPageProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final controller = ref.read(pageControllerProvider);
    final isSelected = currentItem == pageItem;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          child: Column(
            spacing: 2,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: SvgPicture.asset(
                  isSelected ? selectedAsset : asset,
                  key: ValueKey(isSelected),
                  height: 35,
                  width: 35,
                  colorFilter: ColorFilter.mode(
                    isSelected ? colorScheme.primary : colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 300),
                style: isSelected
                    ? textTheme.labelSmall!.copyWith(color: colorScheme.primary)
                    : textTheme.bodySmall!.copyWith(
                        color: colorScheme.secondary,
                      ),
                child: Text(pageItem.name),
              ),
            ],
          ),
        ),
        onTap: () => _handleTap(currentItem, pageItem, ref, controller),
      ),
    );
  }

  void _handleTap(
    HomePageEnum currentItem,
    HomePageEnum targetItem,
    WidgetRef ref,
    PageController controller,
  ) {
    if (currentItem == targetItem) return;

    // Update provider
    ref.read(currentPageProvider.notifier).state = targetItem;

    // Animate PageView to correct page
    controller.animateToPage(
      targetItem.index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
