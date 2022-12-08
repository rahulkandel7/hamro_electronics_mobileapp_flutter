import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/auth/data/repositories/auth_repositoy.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  // set the initial value
  AuthController(this._authRepository) : super(const AsyncData<void>(null));

  final AuthRepository _authRepository;
  loginUser(String email, String password) async {
    var data = {'email': email, 'password': password};
    final result = await _authRepository.login(data);
    result.fold(
      (l) => state = AsyncError(
        l.toString(),
        StackTrace.fromString(
          l.message,
        ),
      ),
      (r) {
        return state = AsyncData(r);
      },
    );
  }

  logout() async {
    final result = await _authRepository.logout();
    result.fold(
      (l) => state = AsyncError(
        l.toString(),
        StackTrace.fromString(
          l.message,
        ),
      ),
      (r) {
        return state = AsyncData(r);
      },
    );
  }

  register(var user) async {
    final result = await _authRepository.register(user);
    result.fold(
      (l) => state = AsyncError(
        l.toString(),
        StackTrace.fromString(
          l.message,
        ),
      ),
      (r) {
        return state = AsyncData(r);
      },
    );
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  return AuthController(ref.watch(authRepositoryProvider));
});
