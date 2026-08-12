import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

final class AuthCubit extends Cubit<AuthState> {
  AuthCubit(AuthRepository authRepository) : super(const AuthInitial()) {
    _subscription = authRepository.authStateChanges.listen(
      (user) =>
          emit(user == null ? const Unauthenticated() : Authenticated(user)),
    );
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
