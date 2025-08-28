import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/home/domain/home_page_enum.dart';
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

    // This is the main shell screen that will be used to navigate between different features of the app.
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: PageView(
            controller: controller,
            children: [
              _buildPage(LandingLogbookScreen()),
              _buildPage(LandingSquadScreen()),
              _buildPage(LandingProfileScreen()), // Placeholder for Analytics
            ],
          ),
          bottomNavigationBar: InteliSwimNavigationBarWidget(),
        ),
      ],
    );
  }

  Widget _buildPage(Widget child) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 70, left: 12, right: 12, bottom: 0),
        child: child,
      ),
    );
  }
}
