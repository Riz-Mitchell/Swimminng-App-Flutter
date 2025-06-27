import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   navigationBar: CupertinoNavigationBar(middle: Text('Home')),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCrossFade(
              firstChild: Text(
                'Welcome to iOS',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              secondChild: Text(
                'Welcome to Splashbook',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              crossFadeState: CrossFadeState.showFirst,
              duration: Duration(milliseconds: 300),
            ),
            Text('Splashbook', style: Theme.of(context).textTheme.displayLarge),
          ],
        ),
      ),
    );
  }
}
