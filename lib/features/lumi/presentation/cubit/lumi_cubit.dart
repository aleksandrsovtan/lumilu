import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/lumi_body.dart';
import '../models/lumi_customization_tab.dart';
import '../models/lumi_hat.dart';
import 'lumi_state.dart';

final class LumiCubit extends Cubit<LumiState> {
  LumiCubit() : super(const LumiState());

  void selectTab(LumiCustomizationTab tab) {
    if (state.selectedTab == tab) return;
    emit(state.copyWith(selectedTab: tab));
  }

  void selectBody(LumiBody body) {
    if (state.selectedBody == body) return;
    emit(state.copyWith(selectedBody: body));
  }

  void selectHat(LumiHat? hat) {
    if (state.selectedHat == hat) return;
    emit(state.copyWith(selectedHat: hat));
  }
}
