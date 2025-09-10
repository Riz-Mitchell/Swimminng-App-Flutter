import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/features/home/presentation/widgets/animated_add_button_widget.dart';
import 'package:swimming_app_frontend/features/home/presentation/widgets/option_widget.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';

class AddOptionsWidget extends ConsumerWidget {
  final bool visible;

  const AddOptionsWidget({super.key, this.visible = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: const Alignment(0.0, -0.2),
      child:
          Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                color: Colors.transparent,
                width: double.infinity,
                height: 530,
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Log Something',
                            style: textTheme.headlineSmall?.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/svg/book.svg',
                            width: 25,
                            height: 25,
                            colorFilter: ColorFilter.mode(
                              colorScheme.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    IntrinsicHeight(
                      child: Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: OptionWidget(
                              text: 'Training Swim',
                              asset: 'assets/svg/whistle.svg',
                              onTap: () {
                                ref
                                    .read(routerProvider)
                                    .push('/add-swim-landing');
                              },
                            ),
                          ),
                          Expanded(
                            child: OptionWidget(
                              text: 'Race Swim',
                              asset: 'assets/svg/rocket.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      radius: BorderRadius.circular(20),
                      thickness: 3,
                      color: Colors.black.withOpacity(0.1),
                      indent: 40,
                      endIndent: 40,
                    ),
                    OptionWidget(
                      text: 'Check In',
                      asset: 'assets/svg/clip_board.svg',
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(
                duration: 500.ms,
                curve: Curves.fastEaseInToSlowEaseOut,
                delay: 100.ms,
              )
              .move(
                begin: const Offset(0, 50), // start 50 pixels below
                end: Offset.zero, // move to final position
                duration: 400.ms,
                curve: Curves.fastEaseInToSlowEaseOut,
              ),
    );
  }
}
