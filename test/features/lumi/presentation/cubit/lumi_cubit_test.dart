import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/features/lumi/presentation/cubit/lumi_cubit.dart';
import 'package:lumilu/features/lumi/presentation/cubit/lumi_state.dart';
import 'package:lumilu/features/lumi/presentation/models/lumi_body.dart';
import 'package:lumilu/features/lumi/presentation/models/lumi_clothing.dart';
import 'package:lumilu/features/lumi/presentation/models/lumi_customization_tab.dart';
import 'package:lumilu/features/lumi/presentation/models/lumi_hat.dart';

void main() {
  group('LumiCubit', () {
    test('starts without a selected hat', () {
      final cubit = LumiCubit();
      addTearDown(cubit.close);

      expect(cubit.state, const LumiState());
    });

    blocTest<LumiCubit, LumiState>(
      'selects a customization tab',
      build: LumiCubit.new,
      act: (cubit) => cubit.selectTab(LumiCustomizationTab.hats),
      expect: () => const [LumiState(selectedTab: LumiCustomizationTab.hats)],
    );

    blocTest<LumiCubit, LumiState>(
      'selects a Lumi body',
      build: LumiCubit.new,
      act: (cubit) => cubit.selectBody(LumiBody.ocean),
      expect: () => const [LumiState(selectedBody: LumiBody.ocean)],
    );

    blocTest<LumiCubit, LumiState>(
      'selects a hat',
      build: LumiCubit.new,
      act: (cubit) => cubit.selectHat(LumiHat.mystery),
      expect: () => const [LumiState(selectedHat: LumiHat.mystery)],
    );

    blocTest<LumiCubit, LumiState>(
      'clears the selected hat',
      build: LumiCubit.new,
      seed: () => const LumiState(selectedHat: LumiHat.mystery),
      act: (cubit) => cubit.selectHat(null),
      expect: () => const [LumiState()],
    );

    blocTest<LumiCubit, LumiState>(
      'does not emit when the same hat is selected again',
      build: LumiCubit.new,
      seed: () => const LumiState(selectedHat: LumiHat.mystery),
      act: (cubit) => cubit.selectHat(LumiHat.mystery),
      expect: () => const <LumiState>[],
    );

    blocTest<LumiCubit, LumiState>(
      'selects clothing',
      build: LumiCubit.new,
      act: (cubit) => cubit.selectClothing(LumiClothing.ocean),
      expect: () => const [LumiState(selectedClothing: LumiClothing.ocean)],
    );

    blocTest<LumiCubit, LumiState>(
      'clears the selected clothing',
      build: LumiCubit.new,
      seed: () => const LumiState(selectedClothing: LumiClothing.premium),
      act: (cubit) => cubit.selectClothing(null),
      expect: () => const [LumiState()],
    );
  });
}
