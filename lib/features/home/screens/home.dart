import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/features/home/widgets/expanding_circle.dart';
import '../widgets/welcome.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          //   navigationBar: CupertinoNavigationBar(middle: Text('Home')),
          body: Center(child: Welcome()),
        ),
        ExpandingCircle(),
      ],
    );
  }
}
