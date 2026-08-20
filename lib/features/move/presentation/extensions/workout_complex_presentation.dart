import 'package:flutter/material.dart';

import '../../../../core/theme/lumilu_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/workout_complex.dart';

extension WorkoutComplexPresentation on WorkoutComplex {
  String get emoji => switch (difficulty) {
    WorkoutComplexDifficulty.easy => '🌱',
    WorkoutComplexDifficulty.medium => '⚡',
    WorkoutComplexDifficulty.hard => '🔥',
  };

  Color get accentColor => switch (difficulty) {
    WorkoutComplexDifficulty.easy => LumiluColors.mint400,
    WorkoutComplexDifficulty.medium => LumiluColors.yellow500,
    WorkoutComplexDifficulty.hard => const Color(0xFFFF8A76),
  };

  String title(AppLocalizations l10n) => switch (difficulty) {
    WorkoutComplexDifficulty.easy => l10n.easyStartTitle,
    WorkoutComplexDifficulty.medium => l10n.inRhythmTitle,
    WorkoutComplexDifficulty.hard => l10n.fullPowerTitle,
  };

  String description(AppLocalizations l10n) => switch (difficulty) {
    WorkoutComplexDifficulty.easy => l10n.easyStartDescription,
    WorkoutComplexDifficulty.medium => l10n.inRhythmDescription,
    WorkoutComplexDifficulty.hard => l10n.fullPowerDescription,
  };

  String meta(AppLocalizations l10n) => switch (difficulty) {
    WorkoutComplexDifficulty.easy => l10n.easyStartMeta,
    WorkoutComplexDifficulty.medium => l10n.inRhythmMeta,
    WorkoutComplexDifficulty.hard => l10n.fullPowerMeta,
  };
}

extension WorkoutExercisePresentation on WorkoutExercise {
  String title(AppLocalizations l10n) => switch (id) {
    'head_nod' => l10n.exerciseHeadNodTitle,
    'head_turn' => l10n.exerciseHeadTurnTitle,
    'squat' => l10n.exerciseSquatsTitle,
    _ => name,
  };

  String description(AppLocalizations l10n) => switch (id) {
    'head_nod' => l10n.exerciseHeadNodDescription,
    'head_turn' => l10n.exerciseHeadTurnDescription,
    'squat' => l10n.exerciseSquatsDescription,
    _ => name,
  };

  String duration(AppLocalizations l10n) => '$targetRepetitions ×';
}
