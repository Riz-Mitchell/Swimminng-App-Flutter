import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swimming_app_frontend/shared/application/nav_direction_provider.dart';

CustomTransitionPage<T> buildPageWithDirectionalSlide<T>({
  required Widget child,
  required NavigationDirection direction,
}) {
  return CustomTransitionPage<T>(
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offset = direction == NavigationDirection.forward
          ? const Offset(1.0, 0.0) // from right
          : const Offset(-1.0, 0.0); // from left

      return SlideTransition(
        position: Tween<Offset>(
          begin: offset,
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
    child: child,
  );
}
