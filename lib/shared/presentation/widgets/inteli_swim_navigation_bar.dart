import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InteliSwimNavigationBar extends ConsumerWidget {
  const InteliSwimNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            print('going home');
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            print('searching');
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            print('notification');
          },
        ),
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            print('person');
          },
        ),
      ],
    );
  }
}
