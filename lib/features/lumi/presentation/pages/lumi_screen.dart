import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/lumi_cubit.dart';
import '../cubit/lumi_state.dart';
import '../models/lumi_body.dart';
import '../models/lumi_clothing.dart';
import '../models/lumi_customization_tab.dart';
import '../models/lumi_hat.dart';
import '../widgets/lumi_char.dart';
import '../widgets/lumi_coming_soon.dart';
import '../widgets/lumi_customization_tabs.dart';
import '../widgets/lumi_item_list.dart';

class LumiScreen extends StatelessWidget {
  const LumiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => LumiCubit(), child: const _LumiView());
  }
}

class _LumiView extends StatelessWidget {
  const _LumiView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
        BlocSelector<LumiCubit, LumiState, (LumiBody, LumiHat?, LumiClothing?)>(
          selector: (state) => (state.selectedBody, state.selectedHat, state.selectedClothing),
          builder: (context, selection) =>
              LumiChar(selectedBody: selection.$1, selectedHat: selection.$2, selectedClothing: selection.$3),
        ),
        BlocSelector<LumiCubit, LumiState, LumiCustomizationTab>(
          selector: (state) => state.selectedTab,
          builder: (context, selectedTab) =>
              LumiCustomizationTabs(selectedTab: selectedTab, onSelected: context.read<LumiCubit>().selectTab),
        ),
        Expanded(
          child: SafeArea(
            top: false,
            child: BlocBuilder<LumiCubit, LumiState>(
              builder: (context, state) {
                return switch (state.selectedTab) {
                  LumiCustomizationTab.hats => LumiItemList<LumiHat?>(
                    key: const Key('lumi-hat-grid'),
                    items: <LumiHat?>[null, ...LumiHat.values],
                    selectedItem: state.selectedHat,
                    assetPathOf: (hat) => hat?.assetPath,
                    idOf: (hat) => hat?.name ?? 'none-hat',
                    onSelected: context.read<LumiCubit>().selectHat,
                  ),
                  LumiCustomizationTab.lumi => LumiItemList<LumiBody>(
                    key: const Key('lumi-body-grid'),
                    items: LumiBody.values,
                    selectedItem: state.selectedBody,
                    assetPathOf: (body) => body.assetPath,
                    idOf: (body) => '${body.name}-body',
                    onSelected: context.read<LumiCubit>().selectBody,
                  ),
                  LumiCustomizationTab.clothes => LumiItemList<LumiClothing?>(
                    key: const Key('lumi-clothing-grid'),
                    items: <LumiClothing?>[null, ...LumiClothing.values],
                    selectedItem: state.selectedClothing,
                    assetPathOf: (clothing) => clothing?.assetPath,
                    idOf: (clothing) => clothing?.name ?? 'none-clothing',
                    onSelected: context.read<LumiCubit>().selectClothing,
                  ),
                  _ => const LumiComingSoon(),
                };
              },
            ),
          ),
        ),
      ],
    );
  }
}
