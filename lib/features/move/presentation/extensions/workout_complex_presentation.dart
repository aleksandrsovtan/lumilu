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
  String title(AppLocalizations l10n) => switch (type) {
    WorkoutExerciseType.breathing => l10n.exerciseBreathingTitle,
    WorkoutExerciseType.shoulderCircles => l10n.exerciseShoulderCirclesTitle,
    WorkoutExerciseType.sideBends => l10n.exerciseSideBendsTitle,
    WorkoutExerciseType.easySquats => l10n.exerciseEasySquatsTitle,
    WorkoutExerciseType.march => l10n.exerciseMarchTitle,
    WorkoutExerciseType.jumpingJacks => l10n.exerciseJumpingJacksTitle,
    WorkoutExerciseType.squats => l10n.exerciseSquatsTitle,
    WorkoutExerciseType.kneeRaises => l10n.exerciseKneeRaisesTitle,
    WorkoutExerciseType.lunges => l10n.exerciseLungesTitle,
    WorkoutExerciseType.plank => l10n.exercisePlankTitle,
    WorkoutExerciseType.mountainClimbers => l10n.exerciseMountainClimbersTitle,
    WorkoutExerciseType.pushUps => l10n.exercisePushUpsTitle,
    WorkoutExerciseType.jumpSquats => l10n.exerciseJumpSquatsTitle,
    WorkoutExerciseType.burpees => l10n.exerciseBurpeesTitle,
    WorkoutExerciseType.highKnees => l10n.exerciseHighKneesTitle,
    WorkoutExerciseType.bicycleCrunches => l10n.exerciseBicycleCrunchesTitle,
  };

  String description(AppLocalizations l10n) => switch (type) {
    WorkoutExerciseType.breathing => l10n.exerciseBreathingDescription,
    WorkoutExerciseType.shoulderCircles =>
      l10n.exerciseShoulderCirclesDescription,
    WorkoutExerciseType.sideBends => l10n.exerciseSideBendsDescription,
    WorkoutExerciseType.easySquats => l10n.exerciseEasySquatsDescription,
    WorkoutExerciseType.march => l10n.exerciseMarchDescription,
    WorkoutExerciseType.jumpingJacks => l10n.exerciseJumpingJacksDescription,
    WorkoutExerciseType.squats => l10n.exerciseSquatsDescription,
    WorkoutExerciseType.kneeRaises => l10n.exerciseKneeRaisesDescription,
    WorkoutExerciseType.lunges => l10n.exerciseLungesDescription,
    WorkoutExerciseType.plank => l10n.exercisePlankDescription,
    WorkoutExerciseType.mountainClimbers =>
      l10n.exerciseMountainClimbersDescription,
    WorkoutExerciseType.pushUps => l10n.exercisePushUpsDescription,
    WorkoutExerciseType.jumpSquats => l10n.exerciseJumpSquatsDescription,
    WorkoutExerciseType.burpees => l10n.exerciseBurpeesDescription,
    WorkoutExerciseType.highKnees => l10n.exerciseHighKneesDescription,
    WorkoutExerciseType.bicycleCrunches =>
      l10n.exerciseBicycleCrunchesDescription,
  };

  String duration(AppLocalizations l10n) =>
      l10n.approximateSeconds(durationSeconds);
}
