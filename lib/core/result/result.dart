import '../errors/app_failure.dart';
import '../functional/either.dart';

typedef Result<T> = Either<AppFailure, T>;
