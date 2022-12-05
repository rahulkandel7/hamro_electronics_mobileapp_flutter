import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade200,
  backgroundColor: Colors.indigo,
  cardColor: Colors.grey.shade100,
  errorColor: Colors.red.shade800,
  indicatorColor: Colors.indigo.shade100,
  primarySwatch: Colors.indigo,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.indigo.shade900,
      fontFamily: 'Poppins',
    ),
    headline2: TextStyle(
      color: Colors.indigo.shade900,
      fontWeight: FontWeight.normal,
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
);

ThemeData darkTheme = ThemeData(
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
);
