import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade100,
  primarySwatch: Colors.indigo,
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.bold,
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
);
