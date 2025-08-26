import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class OnboardAppStartScreen extends ConsumerWidget {
  const OnboardAppStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            top: 70,
            left: 12,
            right: 12,
            bottom: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 125),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'InteliSwim',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  Text(
                    'Swim smarter swim faster.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 425),
              MetricButtonWidget(
                text: 'Create account',
                onPressed: () {
                  ref.read(routerProvider).go('/ca-initial');
                },
              ),
              MetricButtonWidget(
                text: 'Sign in',
                metricColor: Colors.transparent,
                onPressed: () {
                  ref.read(routerProvider).go('/login-phonenumber');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
