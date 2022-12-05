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
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        backgroundColor: Colors.grey.shade300,
        errorColor: Colors.red.shade400,
        cardColor: Colors.grey.shade900,
        indicatorColor: Colors.grey.shade400,
        scaffoldBackgroundColor: Colors.grey.shade900,
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(
          subtitle1: TextStyle(
            color: Colors.grey.shade200,
          ),
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade700,
            fontFamily: 'Poppins',
          ),
          headline2: TextStyle(
            color: Colors.grey.shade100,
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins',
          ),
          headline5: TextStyle(
            color: Colors.grey.shade300,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
          headline6: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey.shade300,
          ),
          headline4: TextStyle(
            color: Colors.grey.shade300,
            fontFamily: 'Poppins',
          ),
          bodyText1: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey.shade300,
          ),
          bodyText2: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey.shade300,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade100,
              width: 0.7,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 0.7,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.red.shade300,
              width: 0.7,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 0.7,
            ),
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.grey.shade300,
          ),
          labelStyle: TextStyle(
            color: Colors.grey.shade50,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        chipTheme: ChipThemeData(
          pressElevation: 2.0,
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.grey.shade500,
          selectedColor: Colors.indigo,
        ),
      ),
      theme: lightTheme,
      home: ref.watch(sharedPreferencesProvider).getBool('isFirst')!
          ? const Navbar()
          : const OnBoardingScreen(),
      routes: routes,
    );
  }
}
