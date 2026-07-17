import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('domain layer has no framework or outer-layer dependencies', () {
    final violations = _dartFilesUnder('lib/features')
        .where((file) => file.path.contains('/domain/'))
        .where(
          (file) => _containsAny(file, const [
            "package:flutter/",
            "package:get_it/",
            "package:lumilu_motion/",
            "/data/",
            "/presentation/",
          ]),
        )
        .map((file) => file.path)
        .toList();

    expect(violations, isEmpty, reason: 'Domain dependency violations');
  });

  test('presentation does not access DI or the motion SDK directly', () {
    final violations = _dartFilesUnder('lib/features')
        .where((file) => file.path.contains('/presentation/'))
        .where(
          (file) => _containsAny(file, const [
            "package:get_it/",
            "package:lumilu_motion/",
          ]),
        )
        .map((file) => file.path)
        .toList();

    expect(violations, isEmpty, reason: 'Presentation dependency violations');
  });
}

Iterable<File> _dartFilesUnder(String path) => Directory(path)
    .listSync(recursive: true)
    .whereType<File>()
    .where((file) => file.path.endsWith('.dart'));

bool _containsAny(File file, List<String> patterns) {
  final source = file.readAsStringSync();
  return patterns.any(source.contains);
}
