import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userInfoProvider = FutureProvider.autoDispose((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userInfo = prefs.getString('user');

  var userDecoded = json.decode(userInfo!) as Map<String, dynamic>;
  return userDecoded;
});
