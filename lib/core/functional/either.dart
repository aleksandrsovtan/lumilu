sealed class Either<L, R> {
  const Either();

  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  T fold<T>(T Function(L value) onLeft, T Function(R value) onRight) =>
      switch (this) {
        Left(:final value) => onLeft(value),
        Right(:final value) => onRight(value),
      };

  Either<L, T> map<T>(T Function(R value) transform) =>
      fold(Left<L, T>.new, (value) => Right<L, T>(transform(value)));

  Either<T, R> mapLeft<T>(T Function(L value) transform) =>
      fold((value) => Left<T, R>(transform(value)), Right<T, R>.new);

  Either<L, T> flatMap<T>(Either<L, T> Function(R value) transform) =>
      fold(Left<L, T>.new, transform);

  R getOrElse(R Function(L value) fallback) => fold(fallback, (value) => value);

  Either<R, L> swap() => fold(Right<R, L>.new, Left<R, L>.new);
}

final class Left<L, R> extends Either<L, R> {
  const Left(this.value);
  final L value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Left<L, R> && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

final class Right<L, R> extends Either<L, R> {
  const Right(this.value);
  final R value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Right<L, R> && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
