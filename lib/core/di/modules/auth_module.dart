import 'package:get_it/get_it.dart';

import '../../../features/auth/data/repositories/firebase_auth_repository.dart';
import '../../../features/auth/data/repositories/firestore_user_repository.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../../features/auth/domain/repositories/user_repository.dart';
import '../../../features/auth/domain/usecases/sign_up_user.dart';
import '../../../features/auth/presentation/cubit/auth_cubit.dart';

final class AuthModuleMarker {}

void registerAuthModule(GetIt getIt) {
  getIt
    ..registerSingleton(AuthModuleMarker())
    ..registerLazySingleton<AuthRepository>(FirebaseAuthRepository.new)
    ..registerLazySingleton<UserRepository>(FirestoreUserRepository.new)
    ..registerFactory(
      () => SignUpUser(getIt<AuthRepository>(), getIt<UserRepository>()),
    )
    ..registerFactory(() => AuthCubit(getIt<AuthRepository>()));
}
