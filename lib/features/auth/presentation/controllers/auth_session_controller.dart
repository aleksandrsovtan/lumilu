import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthSessionController extends ChangeNotifier {
  AuthSessionController(this._repository) : _user = _repository.currentUser {
    _subscription = _repository.authStateChanges.listen((user) {
      if (_user == user) return;
      _user = user;
      notifyListeners();
    });
  }

  final AuthRepository _repository;
  late final StreamSubscription<AuthUser?> _subscription;
  AuthUser? _user;

  AuthUser? get user => _user;
  bool get isAuthenticated => _user != null;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
