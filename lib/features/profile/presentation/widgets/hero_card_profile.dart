import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

class HeroCardProfile extends ConsumerWidget {
  const HeroCardProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.95,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [metricBlue, metricBlue, metricBlue.withOpacity(0.5)],
          stops: [0.0, 0.6, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        color: metricBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar
            Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: colorScheme.primary,
                      width: 5.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/user_placeholder.svg',
                    width: 250,
                    height: 250,
                    colorFilter: ColorFilter.mode(
                      colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                )
                .animate() // start the animation chain
                .fadeIn(duration: 500.ms, curve: Curves.fastEaseInToSlowEaseOut)
                .move(
                  begin: const Offset(0, 50),
                  end: Offset.zero,
                  duration: 500.ms,
                  curve: Curves.fastEaseInToSlowEaseOut,
                ),

            SizedBox(height: 20),

            // Name
            Text(
                  'Rizzle',
                  style: textTheme.displayMedium?.copyWith(
                    color: colorScheme.primary,
                  ),
                )
                .animate()
                .fadeIn(
                  duration: 400.ms,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  delay: 200.ms, // stagger after avatar
                )
                .move(
                  begin: const Offset(0, 50),
                  end: Offset.zero,
                  duration: 400.ms,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  delay: 200.ms,
                ),

            SizedBox(height: 10),

            // Row with flag & info
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.all(
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: colorScheme.primary,
                          width: 2.0,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'icons/flags/svg/au.svg',
                        package: 'country_icons',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Aus | Nunawading Swimming Club | 21',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                )
                .animate()
                .fadeIn(
                  duration: 400.ms,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  delay: 400.ms, // stagger after name
                )
                .move(
                  begin: const Offset(0, 50),
                  end: Offset.zero,
                  duration: 400.ms,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  delay: 400.ms,
                ),
          ],
        ),
      ),
    );
  }
}
