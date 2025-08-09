import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swimming_app_frontend/shared/infrastructure/api.dart';
import 'package:swimming_app_frontend/shared/presentation/extensions/custom_theme.dart';
import 'package:swimming_app_frontend/shared/application/providers/auth_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/storage_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final storage = Storage(prefs);

  runApp(
    ProviderScope(
      overrides: [storageProvider.overrideWithValue(storage)],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return _EagerInitialisation(
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,

            primary: Color(0xFFFFFFFF), // White for text/icons/buttons
            onPrimary: Color(0xFF000000),

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
            headlineMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 16),
            labelSmall: TextStyle(fontSize: 12, letterSpacing: 1.2),
          ),
          extensions: <ThemeExtension<dynamic>>[
            const CustomColors(
              belowCard: Color(0xFFD8D8D8), // ← your custom color
            ),
          ],
        ),
      ),
    );
  }
}

class _EagerInitialisation extends ConsumerWidget {
  const _EagerInitialisation({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(storageProvider);
    ref.watch(authControllerProvider);
    ref.watch(apiClientProvider);

    return child;
  }
}
