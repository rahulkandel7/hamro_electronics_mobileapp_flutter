import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/data/models/user.dart';

class UserController extends StateNotifier<List<User>> {
  final String url = 'https://www.api.hamroelectronics.com.np/api/v1/';

  UserController(super.createFn);

  //* Function to change password
  Future<http.Response> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.post(Uri.parse('${url}user/changepass'), headers: {
      'Authorization': 'Bearer ${prefs.getString('token')}',
    }, body: {
      'current_password': currentPassword,
      'new_password': newPassword,
    });

    return response;
  }

  //* Function to update Info
  Future<http.Response> updateInfo(
    String name,
    String phone,
    String address,
    String photopath,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (photopath == '') {
      final response =
          await http.post(Uri.parse('${url}user/update'), headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
      }, body: {
        'name': name,
        'address': address,
        'phone_number': phone,
      });

      if (response.statusCode == 200) {
        prefs.remove('user');
        final res = json.decode(response.body);
        prefs.setString('user', json.encode(res['data']));
      }
      return response;
    } else {
      final jsons = {
        'name': name,
        'address': address,
        'phone_number': phone,
      };
      Map<String, String> headers = {
        'Content-Type': "multipart/form-data",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('token')}',
      };

      var request = http.MultipartRequest(
          'POST', Uri.parse("${url}user/update"))
        ..fields.addAll(jsons)
        ..headers.addAll(headers)
        ..files
            .add(await http.MultipartFile.fromPath('profile_photo', photopath));

      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        prefs.remove('user');
        final res = json.decode(response.body);
        prefs.setString('user', json.encode(res['data']));
      }
      print(response.body);
      return response;
    }
  }
}

StateNotifierProvider<UserController, List<User>> userProvider =
    StateNotifierProvider<UserController, List<User>>(
        (ref) => UserController([]));

FutureProvider<bool> tokenProvider = FutureProvider((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') != null ? true : false;
});
