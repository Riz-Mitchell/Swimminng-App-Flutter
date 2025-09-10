import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/user_entity.dart';
import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class HeroCardProfile extends ConsumerWidget {
  final GetUserEntity user;

  const HeroCardProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    print('user: ${user.name}, age: ${user.age}');

    return Container(
      width: screenWidth,
      height: screenHeight * 0.95,
      padding: const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 70),
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
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child:
                IconButtonWidget(
                      path: 'assets/svg/gear.svg',
                      overrideColor: colorScheme.primary,
                      onTapped: () async =>
                          await ref.read(routerProvider).push('/settings'),
                    )
                    .animate()
                    .fadeIn(
                      duration: 400.ms,
                      curve: Curves.fastEaseInToSlowEaseOut,
                    )
                    .move(
                      begin: const Offset(0, 50),
                      end: Offset.zero,
                      duration: 400.ms,
                      curve: Curves.fastEaseInToSlowEaseOut,
                    ),
          ),

          Center(
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
                    .fadeIn(
                      duration: 500.ms,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      delay: 200.ms,
                    )
                    .move(
                      begin: const Offset(0, 50),
                      end: Offset.zero,
                      duration: 500.ms,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      delay: 200.ms,
                    ),

                SizedBox(height: 20),

                // Name
                Text(
                      textAlign: TextAlign.center,
                      user.name,
                      style: textTheme.displayLarge?.copyWith(
                        color: colorScheme.primary,
                      ),
                    )
                    .animate()
                    .fadeIn(
                      duration: 400.ms,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      delay: 400.ms, // stagger after avatar
                    )
                    .move(
                      begin: const Offset(0, 50),
                      end: Offset.zero,
                      duration: 400.ms,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      delay: 400.ms,
                    ),

                SizedBox(height: 10),

                // Row with flag & info
                Row(
                      spacing: 0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
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

                        Text(
                          'Aus | Nunawading Swimming Club | ${user.age}',
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
                      delay: 600.ms, // stagger after name
                    )
                    .move(
                      begin: const Offset(0, 50),
                      end: Offset.zero,
                      duration: 400.ms,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      delay: 600.ms,
                    ),
                SizedBox(height: 20),
                Divider(
                  color: colorScheme.primary,
                  thickness: 1,
                  radius: BorderRadius.circular(20),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${user.streak.currentStreak}',
                            style: textTheme.displayMedium?.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                          Text(
                            'Day Streak',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 1, // thickness
                      height: 120,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(20), // rounded ends
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Friends',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.primary,
                                ),
                              ),
                              Text(
                                '103',
                                style: textTheme.headlineSmall?.copyWith(
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Member Since',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.primary,
                                ),
                              ),
                              Text(
                                user.getMemberSince(),
                                style: textTheme.headlineSmall?.copyWith(
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
