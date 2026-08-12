import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_user.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class Authenticated extends AuthState {
  const Authenticated(this.user);

  final AuthUser user;

  @override
  List<Object?> get props => [user.id, user.email];
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();
}
