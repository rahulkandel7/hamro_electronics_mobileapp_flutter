import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/screens/onboarding_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../screens/navbar.dart';

import '../utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirst = prefs.getBool('isFirst') != null ? true : false;
  runApp(
    ProviderScope(
      child: MyApp(
        isFirst: isFirst,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirst;
  const MyApp({super.key, required this.isFirst});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamro Electronics ',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade200,
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
            fontFamily: 'Poppins',
          ),
          headline5: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
          headline6: const TextStyle(
            fontFamily: 'Poppins',
          ),
          headline4: const TextStyle(
            color: Colors.indigo,
            fontFamily: 'Poppins',
          ),
          bodyText1: const TextStyle(
            fontFamily: 'Poppins',
          ),
          bodyText2: const TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.indigo.shade600,
              width: 0.7,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.indigo.shade600,
              width: 0.7,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.red.shade600,
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
            color: Colors.indigo.shade400,
          ),
          labelStyle: const TextStyle(
            color: Colors.indigo,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        chipTheme: ChipThemeData(
          pressElevation: 2.0,
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.grey.shade500,
          selectedColor: Colors.indigo,
        ),
      ),
      home: isFirst ? const Navbar() : const OnBoardingScreen(),
      routes: routes,
    );
  }
}
