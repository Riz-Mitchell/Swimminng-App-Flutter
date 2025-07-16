import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swimming_app_frontend/api/api.dart';
import 'package:swimming_app_frontend/shared/presentation/extensions/custom_theme.dart';
import 'package:swimming_app_frontend/shared/providers/auth_provider.dart';
import 'package:swimming_app_frontend/shared/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/providers/storage_provider.dart';

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
            brightness: Brightness.light,
            primary: Color(0xFF000000),
            onPrimary: Color(0xFFFFFFFF),
            secondary: Color(0xFF999999),
            onSecondary: Color(0xFFFFFFFF),
            background: Color(0xFFEDEDED),
            onBackground: Color(0xFF212121),
            surface: Color(0xFFFBFBFB),
            onSurface: Color(0xFF212121),
            error: Color(0xFFB00020),
            onError: Color(0xFFFFFFFF),
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            displaySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 16, height: 1.5),
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
