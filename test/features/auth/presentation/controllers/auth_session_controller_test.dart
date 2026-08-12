import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/features/auth/domain/entities/auth_user.dart';
import 'package:lumilu/features/auth/domain/repositories/auth_repository.dart';
import 'package:lumilu/features/auth/presentation/controllers/auth_session_controller.dart';
import 'package:lumilu/l10n/generated/app_localizations.dart';
import 'package:lumilu/router.dart';

void main() {
  test('starts from persisted user and follows auth changes', () async {
    final repository = _FakeAuthRepository(
      const AuthUser(id: 'persisted', email: 'lumi@example.com'),
    );
    final controller = AuthSessionController(repository);
    addTearDown(controller.dispose);

    expect(controller.isAuthenticated, isTrue);
    expect(controller.user?.id, 'persisted');

    repository.emit(null);
    await Future<void>.delayed(Duration.zero);
    expect(controller.isAuthenticated, isFalse);
  });

  testWidgets('router restores session and protects signed-in routes', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(800, 900);
    addTearDown(tester.view.reset);
    final repository = _FakeAuthRepository(
      const AuthUser(id: 'persisted', email: 'lumi@example.com'),
    );
    final controller = AuthSessionController(repository);
    final router = createAppRouter(authSessionController: controller);
    addTearDown(() {
      router.dispose();
      controller.dispose();
    });

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
    await tester.pumpAndSettle();
    expect(router.state.uri.path, AppRoutes.home);

    repository.emit(null);
    await tester.pumpAndSettle();
    expect(router.state.uri.path, AppRoutes.welcome);

    router.go(AppRoutes.home);
    await tester.pumpAndSettle();
    expect(router.state.uri.path, AppRoutes.welcome);
  });
}

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository(this._currentUser);

  final _controller = StreamController<AuthUser?>.broadcast();
  AuthUser? _currentUser;

  void emit(AuthUser? user) {
    _currentUser = user;
    _controller.add(user);
  }

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  Stream<AuthUser?> get authStateChanges => _controller.stream;

  @override
  Future<void> deleteCurrentUser() async => emit(null);

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<AuthUser> signIn({required String email, required String password}) =>
      throw UnimplementedError();

  @override
  Future<void> signOut() async => emit(null);

  @override
  Future<AuthUser> signUp({required String email, required String password}) =>
      throw UnimplementedError();
}
