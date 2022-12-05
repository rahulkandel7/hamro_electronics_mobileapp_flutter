import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/features/onboarding/screen/onboarding_screen.dart';
import 'src/navbar.dart';
import 'src/utils/router.dart';
import 'src/utils/sharedProvider.dart';
import 'src/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Hamro Electronics ',
      themeMode: ThemeMode.light,
      darkTheme: darkTheme,
      theme: lightTheme,
      home: ref.watch(sharedPreferencesProvider).getBool('isFirst')!
          ? const Navbar()
          : const OnBoardingScreen(),
      routes: routes,
    );
  }
}
