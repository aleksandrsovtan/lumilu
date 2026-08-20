import 'package:get_it/get_it.dart';

import 'modules/auth_module.dart';
import 'modules/exercises_module.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  if (!getIt.isRegistered<AuthModuleMarker>()) registerAuthModule(getIt);
  if (getIt.isRegistered<ExercisesModuleMarker>()) return;
  registerExercisesModule(getIt);
}
