import '../entities/user_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

final class SignUpUser {
  const SignUpUser(this._authRepository, this._userRepository);

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<UserModel> call({
    required String email,
    required String password,
    required String name,
  }) async {
    final user = await _authRepository.signUp(email: email, password: password);

    try {
      await _userRepository.createUser(
        uid: user.id,
        email: user.email ?? email.trim(),
        name: name,
      );
    } catch (_) {
      try {
        await _authRepository.deleteCurrentUser();
      } catch (_) {
        await _authRepository.signOut();
      }
      rethrow;
    }

    return UserModel(
      id: user.id,
      email: user.email ?? email.trim(),
      name: name.trim(),
      createdAt: null,
      updatedAt: null,
    );
  }
}
