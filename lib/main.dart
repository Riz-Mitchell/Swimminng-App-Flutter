import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/core/router.dart';
import 'package:swimming_app_frontend/features/app_start/ui/screens/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF000000),
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFF999999),
          onSecondary: Color(0xFFFFFFFF),
          background: Color(0xFFF5F5F5),
          onBackground: Color(0xFF212121),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF212121),
          error: Color(0xFFB00020),
          onError: Color(0xFFFFFFFF),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16, height: 1.5),
          labelSmall: TextStyle(fontSize: 12, letterSpacing: 1.2),
        ),
      ),
    );
  }
}
