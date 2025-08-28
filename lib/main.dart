import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/presentation/extensions/custom_theme.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
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
          brightness: Brightness.dark,

          primary: Color(0xFFFFFFFF), // White for text/icons/buttons
          onPrimary: Color(0xFF000000),
          onPrimaryContainer: Color(0xFFE0E0E0),

          background: Color(0xFF0A0A0A), // Deep black background
          onBackground: Color(0xFFEDEDED), // Light text

          surface: Color(
            0xFF131313,
          ), // Slightly lighter than background for cards
          onSurface: Color(0xFFFFFFFF),

          // Use this for error states only
          error: Color(0xFFFF3B30),
          onError: Color(0xFFFFFFFF),

          // UNUSED — you can repurpose secondary if you like
          secondary: Color(0xFF888888),
          onSecondary: Color(0xFFFFFFFF),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 24),
          bodyMedium: TextStyle(fontSize: 16),
          bodySmall: TextStyle(fontSize: 14),
          labelSmall: TextStyle(fontSize: 12),
        ),
        extensions: <ThemeExtension<dynamic>>[
          const CustomColors(
            belowCard: Color(0xFFD8D8D8), // ← your custom color
          ),
        ],
      ),
    );
  }
}
