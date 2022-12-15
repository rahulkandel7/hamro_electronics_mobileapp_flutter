import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repositoy.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  // set the initial value
  AuthController(this._authRepository) : super(const AsyncData<void>(null));

  final AuthRepository _authRepository;
  Future<List<String>> loginUser(String email, String password) async {
    String firebaseToken = '';
    await FirebaseMessaging.instance.getToken().then((token) {
      firebaseToken = token!;
    });
    var data = {
      'email': email,
      'password': password,
      'device_token': firebaseToken
    };
    final result = await _authRepository.login(data);
    return result.fold(
      (error) {
        List<String> msg = ['false', error.message];
        return msg;
      },
      (success) {
        List<String> msg = ['true', success];
        return msg;
      },
    );
  }

  Future<List<String>> logout() async {
    final result = await _authRepository.logout();

    return result.fold(
      (error) {
        List<String> msg = ['false', error.message];
        return msg;
      },
      (success) {
        List<String> msg = ['true', success];
        return msg;
      },
    );
  }

  Future<List<String>> register(Map<String, String> user) async {
    String firebaseToken = '';
    await FirebaseMessaging.instance.getToken().then((token) {
      firebaseToken = token!;
    });
    Map<String, String> ftoken = {'device_token': firebaseToken};

    user.addEntries(ftoken.entries);

    print(user);

    final result = await _authRepository.register(user);
    return result.fold(
      (error) {
        List<String> msg = ['false', error.message];
        return msg;
      },
      (success) {
        List<String> msg = ['true', success];
        return msg;
      },
    );
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  return AuthController(ref.watch(authRepositoryProvider));
});
