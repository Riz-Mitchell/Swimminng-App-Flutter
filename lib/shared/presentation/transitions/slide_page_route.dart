import 'package:flutter/material.dart';

class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final AxisDirection direction;

  SlidePageRoute({required this.page, this.direction = AxisDirection.left})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Determine the offset based on direction
          Offset begin, end = Offset.zero;
          switch (direction) {
            case AxisDirection.up:
              begin = const Offset(0, 1);
              break;
            case AxisDirection.down:
              begin = const Offset(0, -1);
              break;
            case AxisDirection.right:
              begin = const Offset(-1, 0);
              break;
            case AxisDirection.left:
              begin = const Offset(1, 0);
              break;
          }

          // Incoming page animation
          final tweenIn = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeInOut));

          // Outgoing page animation (opposite direction)
          final tweenOut = Tween(
            begin: Offset.zero,
            end: -begin,
          ).chain(CurveTween(curve: Curves.easeInOut));

          return Stack(
            children: [
              // Outgoing page
              SlideTransition(
                position: secondaryAnimation.drive(tweenOut),
                child: child,
              ),
              // Incoming page
              SlideTransition(position: animation.drive(tweenIn), child: child),
            ],
          );
        },
      );
}
