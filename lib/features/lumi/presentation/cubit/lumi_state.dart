import 'package:equatable/equatable.dart';

import '../models/lumi_body.dart';
import '../models/lumi_customization_tab.dart';
import '../models/lumi_hat.dart';

const _unset = Object();

final class LumiState extends Equatable {
  const LumiState({
    this.selectedTab = LumiCustomizationTab.achievements,
    this.selectedBody = LumiBody.base,
    this.selectedHat,
  });

  final LumiCustomizationTab selectedTab;
  final LumiBody selectedBody;
  final LumiHat? selectedHat;

  LumiState copyWith({
    LumiCustomizationTab? selectedTab,
    LumiBody? selectedBody,
    Object? selectedHat = _unset,
  }) => LumiState(
    selectedTab: selectedTab ?? this.selectedTab,
    selectedBody: selectedBody ?? this.selectedBody,
    selectedHat: identical(selectedHat, _unset)
        ? this.selectedHat
        : selectedHat as LumiHat?,
  );

  @override
  List<Object?> get props => [selectedTab, selectedBody, selectedHat];
}
