import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

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
