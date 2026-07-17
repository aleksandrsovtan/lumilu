import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/core/functional/either.dart';

void main() {
  test('map and flatMap transform only Right values', () {
    const Either<String, int> value = Right(2);

    final result = value
        .map((number) => number * 2)
        .flatMap((number) => Right<String, String>('value: $number'));

    expect(result, const Right<String, String>('value: 4'));
  });

  test('Left bypasses right-side transformations', () {
    const Either<String, int> value = Left('failure');

    final result = value.map((number) => number * 2);

    expect(result, const Left<String, int>('failure'));
    expect(result.getOrElse((_) => 42), 42);
  });
}
