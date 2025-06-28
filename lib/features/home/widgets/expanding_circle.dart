import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './welcome.dart';

class CircleAnimationNotifier extends ChangeNotifier {
  late AnimationController controller;
  late Animation<double> animation;

  CircleAnimationNotifier(TickerProvider vsync) {
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

final circleAnimationProvider =
    ChangeNotifierProvider.family<CircleAnimationNotifier, TickerProvider>((
      ref,
      vsync,
    ) {
      final notifier = CircleAnimationNotifier(vsync);
      ref.onDispose(() => notifier.disposeController());
      return notifier;
    });

class ExpandingCircle extends ConsumerStatefulWidget {
  const ExpandingCircle({super.key});

  @override
  ConsumerState<ExpandingCircle> createState() =>
      _ExpandingCircleOverlayState();
}

class _ExpandingCircleOverlayState extends ConsumerState<ExpandingCircle>
    with SingleTickerProviderStateMixin {
  bool _hasStarted = false;

  @override
  Widget build(BuildContext context) {
    final welcomeDone = ref.watch(welcomeCompleteProvider);
    final animationNotifier = ref.watch(circleAnimationProvider(this));

    if (welcomeDone && !_hasStarted) {
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
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
