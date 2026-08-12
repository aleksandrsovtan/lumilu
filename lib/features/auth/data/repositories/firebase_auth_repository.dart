import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';

final class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  @override
  AuthUser? get currentUser => _auth.currentUser?.toAuthUser();

  @override
  Stream<AuthUser?> get authStateChanges =>
      _auth.authStateChanges().map((user) => user?.toAuthUser());

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    return credential.user?.toAuthUser() ??
        (throw StateError('Firebase user was not created.'));
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    return credential.user?.toAuthUser() ??
        (throw StateError('Firebase user is unavailable.'));
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<void> deleteCurrentUser() async {
    await _auth.currentUser?.delete();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());
}

extension on User {
  AuthUser toAuthUser() => AuthUser(id: uid, email: email);
}
