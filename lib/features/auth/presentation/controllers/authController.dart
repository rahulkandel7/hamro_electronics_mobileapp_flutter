import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repositoy.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  // set the initial value
  AuthController(this._authRepository) : super(const AsyncData<void>(null));

  final AuthRepository _authRepository;
  Future<List<String>> loginUser(String email, String password) async {
    var data = {'email': email, 'password': password};
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

  Future<List<String>> register(var user) async {
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
