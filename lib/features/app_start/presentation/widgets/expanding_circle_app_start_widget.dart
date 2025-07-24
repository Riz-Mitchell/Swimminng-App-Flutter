import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/app_start/providers/splash_status_provider.dart';

// Animation controller class
class ExpandingCircleAnimationNotifier extends ChangeNotifier {
  late final AnimationController controller;
  late final Animation<double> animation;

  ExpandingCircleAnimationNotifier(TickerProvider vsync) {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: vsync,
    );

    animation =
        Tween<double>(begin: 0, end: 1000).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        )..addListener(() {
          notifyListeners();
        });
  }

  void start() {
    controller.forward();
  }

  void disposeController() {
    controller.dispose();
  }
}

// Riverpod provider using ChangeNotifierProvider.family
final circleAnimationProvider =
    ChangeNotifierProvider.family<
      ExpandingCircleAnimationNotifier,
      TickerProvider
    >((ref, vsync) {
      final notifier = ExpandingCircleAnimationNotifier(vsync);
      ref.onDispose(() => notifier.disposeController());
      return notifier;
    });

class ExpandingCircleAppStartWidget extends ConsumerStatefulWidget {
  const ExpandingCircleAppStartWidget({super.key});

  @override
  ConsumerState<ExpandingCircleAppStartWidget> createState() =>
      _ExpandingCircleAppStartWidgetState();
}

class _ExpandingCircleAppStartWidgetState
    extends ConsumerState<ExpandingCircleAppStartWidget>
    with SingleTickerProviderStateMixin {
  bool _hasStarted = false;

  @override
  Widget build(BuildContext context) {
    final splashStatus = ref.watch(splashStatusProvider);
    final animationNotifier = ref.watch(circleAnimationProvider(this));

    if (splashStatus == SplashStatus.expandCircle && !_hasStarted) {
      _hasStarted = true;
      animationNotifier.start();
    }

    return Positioned.fill(
      child: Center(
        child: OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: Container(
            width: animationNotifier.animation.value * 10,
            height: animationNotifier.animation.value * 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
