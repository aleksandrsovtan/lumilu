import 'package:equatable/equatable.dart';

import '../models/lumi_body.dart';
import '../models/lumi_clothing.dart';
import '../models/lumi_customization_tab.dart';
import '../models/lumi_hat.dart';

const _unset = Object();

final class LumiState extends Equatable {
  const LumiState({
    this.selectedTab = LumiCustomizationTab.achievements,
    this.selectedBody = LumiBody.base,
    this.selectedHat,
    this.selectedClothing,
  });

  final LumiCustomizationTab selectedTab;
  final LumiBody selectedBody;
  final LumiHat? selectedHat;
  final LumiClothing? selectedClothing;

  LumiState copyWith({
    LumiCustomizationTab? selectedTab,
    LumiBody? selectedBody,
    Object? selectedHat = _unset,
    Object? selectedClothing = _unset,
  }) => LumiState(
    selectedTab: selectedTab ?? this.selectedTab,
    selectedBody: selectedBody ?? this.selectedBody,
    selectedHat: identical(selectedHat, _unset)
        ? this.selectedHat
        : selectedHat as LumiHat?,
    selectedClothing: identical(selectedClothing, _unset)
        ? this.selectedClothing
        : selectedClothing as LumiClothing?,
  );

  @override
  List<Object?> get props => [
    selectedTab,
    selectedBody,
    selectedHat,
    selectedClothing,
  ];
}
