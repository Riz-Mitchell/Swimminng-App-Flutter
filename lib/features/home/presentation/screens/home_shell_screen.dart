import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/home/domain/home_page_enum.dart';
import 'package:swimming_app_frontend/features/home/presentation/widgets/add_options_widget.dart';
import 'package:swimming_app_frontend/features/home/presentation/widgets/animated_add_button_widget.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/screens/landing_logbook_screen.dart';
import 'package:swimming_app_frontend/features/profile/presentation/screens/landing_profile_screen.dart';
import 'package:swimming_app_frontend/features/squad/presentation/screens/landing_squad_screen.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/inteli_swim_navigation_bar_widget.dart';

final currentPageProvider = StateProvider<HomePageEnum>(
  (ref) => HomePageEnum.logbook,
);

final pageControllerProvider = Provider<PageController>((ref) {
  final controller = PageController(
    initialPage: ref.read(currentPageProvider).index,
  );

  // Keep provider in sync when user swipes
  controller.addListener(() {
    final currentIndex = controller.page?.round() ?? 0;
    final pageEnum = HomePageEnum.values[currentIndex];
    if (ref.read(currentPageProvider) != pageEnum) {
      ref.read(currentPageProvider.notifier).state = pageEnum;
    }
  });

  return controller;
});

class HomeShellScreen extends ConsumerWidget {
  const HomeShellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(pageControllerProvider);
    final currentPage = ref.watch(currentPageProvider);
    final isButtonEngaged = ref.watch(testSelectedProvider);

    // This is the main shell screen that will be used to navigate between different features of the app.
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: PageView(
            clipBehavior: Clip.antiAlias,
            controller: controller,
            physics: NeverScrollableScrollPhysics(),
            // currentPage == HomePageEnum.logbook && isButtonEngaged
            //     ? const NeverScrollableScrollPhysics()
            //     : const PageScrollPhysics(),
            children: [
              _buildPage(LandingLogbookScreen()),
              _buildPage(LandingSquadScreen()),
              _buildPage(
                LandingProfileScreen(),
                isProfile: true,
              ), // Placeholder for Analytics
            ],
          ),
          bottomNavigationBar: InteliSwimNavigationBarWidget(),
        ),
        // AddOptionsWidget(
        //   visible: currentPage == HomePageEnum.logbook && isButtonEngaged,
        // ),
        AnimatedAddButtonWidget(visible: currentPage == HomePageEnum.logbook),
        if (isButtonEngaged)
          AddOptionsWidget(
            visible: currentPage == HomePageEnum.logbook && isButtonEngaged,
          ),
      ],
    );
  }

  Widget _buildPage(Widget child, {bool isProfile = false}) {
    return SingleChildScrollView(
      child: Container(
        margin: (!isProfile)
            ? const EdgeInsets.only(top: 70, left: 12, right: 12, bottom: 0)
            : const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
        child: child,
      ),
    );
  }
}
