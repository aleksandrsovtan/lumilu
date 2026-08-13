import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations_extension.dart';
import '../../domain/entities/workout_complex.dart';
import 'custom_workout_card.dart';
import 'workout_complex_card.dart';

class AnimatedComplexPicker extends StatelessWidget {
  const AnimatedComplexPicker({
    required this.complexes,
    required this.selectedComplex,
    required this.customWorkoutName,
    required this.detailsComplex,
    required this.onSelectComplex,
    required this.onToggleDetails,
    required this.onSelectCustom,
    required this.onStart,
    super.key,
  });

  static const _duration = Duration(milliseconds: 720);
  static const _curve = Curves.easeInOutCubicEmphasized;
  static const _buttonHeight = 56.0;
  static const _gap = 12.0;
  static const _sectionGap = 22.0;
  static const _detailsBottomInset = 12.0;

  final List<WorkoutComplex> complexes;
  final WorkoutComplex? selectedComplex;
  final String? customWorkoutName;
  final WorkoutComplex? detailsComplex;
  final ValueChanged<WorkoutComplex> onSelectComplex;
  final ValueChanged<WorkoutComplex> onToggleDetails;
  final VoidCallback onSelectCustom;
  final VoidCallback onStart;

  bool get _hasSelection =>
      selectedComplex != null || customWorkoutName != null;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => _buildPicker(
      context,
      _PickerMetrics.from(context, constraints.maxWidth),
    ),
  );

  Widget _buildPicker(BuildContext context, _PickerMetrics metrics) {
    final options = <_PickerOption>[
      for (final complex in complexes) _PickerOption.complex(complex),
      const _PickerOption.custom(),
    ];
    final ordered = _hasSelection
        ? [
            ...options.where(_isSelected),
            ...options.where((option) => !_isSelected(option)),
          ]
        : options;
    final positions = <_PickerOption, double>{};
    var top = 0.0;

    for (var index = 0; index < ordered.length; index++) {
      final option = ordered[index];
      positions[option] = top;
      top += _heightFor(option, metrics);
      if (index == 0 && _hasSelection) {
        top += _sectionGap + _buttonHeight + _sectionGap;
      } else if (index < ordered.length - 1) {
        top += _gap;
      }
    }

    return AnimatedContainer(
      duration: _duration,
      curve: _curve,
      height: top,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (final option in options)
            AnimatedPositioned(
              key: ValueKey(option.id),
              duration: _duration,
              curve: _curve,
              top: positions[option],
              left: _isSelected(option) ? 0 : (_hasSelection ? 14 : 0),
              right: _isSelected(option) ? 0 : (_hasSelection ? 14 : 0),
              height: _heightFor(option, metrics),
              child: option.complex != null
                  ? WorkoutComplexCard(
                      key: Key(
                        'move-${option.complex!.difficulty.name}-workout',
                      ),
                      complex: option.complex!,
                      exerciseItemHeight: metrics.exerciseHeight,
                      isSelected: _isSelected(option),
                      isCompact: !_isDetailed(option),
                      onToggleDetails: () => onToggleDetails(option.complex!),
                      onSelect: () => onSelectComplex(option.complex!),
                    )
                  : CustomWorkoutCard(
                      key: const Key('move-custom-workout'),
                      name: customWorkoutName,
                      isSelected: _isSelected(option),
                      onTap: onSelectCustom,
                    ),
            ),
          AnimatedPositioned(
            duration: _duration,
            curve: _curve,
            top: _hasSelection
                ? _heightFor(ordered.first, metrics) + _sectionGap
                : top - _buttonHeight,
            left: _hasSelection ? 0 : 32,
            right: _hasSelection ? 0 : 32,
            height: _buttonHeight,
            child: IgnorePointer(
              ignoring: !_hasSelection,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 360),
                curve: Curves.easeOut,
                opacity: _hasSelection ? 1 : 0,
                child: FilledButton.icon(
                  key: const Key('move-start-selected-workout'),
                  onPressed: onStart,
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: Text(context.l10n.startNow),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isSelected(_PickerOption option) => option.complex != null
      ? option.complex == selectedComplex
      : customWorkoutName != null;

  bool _isDetailed(_PickerOption option) => option.complex == detailsComplex;

  double _heightFor(_PickerOption option, _PickerMetrics metrics) {
    final baseHeight = _isSelected(option)
        ? metrics.selectedHeight
        : (_hasSelection ? metrics.alternativeHeight : metrics.compactHeight);
    if (!_isDetailed(option)) return baseHeight;
    final exerciseCount = option.complex?.exerciseCount ?? 0;
    return baseHeight +
        (exerciseCount * metrics.exerciseHeight) +
        _detailsBottomInset;
  }
}

class _PickerMetrics {
  const _PickerMetrics({
    required this.compactHeight,
    required this.selectedHeight,
    required this.alternativeHeight,
    required this.exerciseHeight,
  });

  factory _PickerMetrics.from(BuildContext context, double width) {
    final textScale = MediaQuery.textScalerOf(context).scale(16) / 16;
    final normalizedScale = textScale.clamp(1.0, 2.0);
    final compactHeight = 112 + ((normalizedScale - 1) * 64);
    return _PickerMetrics(
      compactHeight: compactHeight,
      selectedHeight: compactHeight + 12,
      alternativeHeight: compactHeight - 8,
      exerciseHeight: 74 + ((normalizedScale - 1) * 44) + (width < 350 ? 4 : 0),
    );
  }

  final double compactHeight;
  final double selectedHeight;
  final double alternativeHeight;
  final double exerciseHeight;
}

class _PickerOption {
  const _PickerOption.complex(this.complex);

  const _PickerOption.custom() : complex = null;

  final WorkoutComplex? complex;
  String get id =>
      complex == null ? 'custom' : 'complex-${complex!.difficulty.name}';

  @override
  bool operator ==(Object other) => other is _PickerOption && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
