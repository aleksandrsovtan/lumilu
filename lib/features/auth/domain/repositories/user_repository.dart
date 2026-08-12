import '../entities/user_model.dart';

abstract interface class UserRepository {
  Future<void> createUser({
    required String uid,
    required String email,
    required String name,
  });

  Future<UserModel?> getUser(String uid);
}
