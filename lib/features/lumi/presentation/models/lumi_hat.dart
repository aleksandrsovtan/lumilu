enum LumiHat { mystery, ocean, banana, cosmic }

extension LumiHatAsset on LumiHat {
  String get assetPath => switch (this) {
    LumiHat.mystery => 'assets/images/lumi_tab/head/hat_mystery.webp',
    LumiHat.ocean => 'assets/images/lumi_tab/head/hat_ocean.webp',
    LumiHat.banana => 'assets/images/lumi_tab/head/hat_banana.webp',
    LumiHat.cosmic => 'assets/images/lumi_tab/head/hat_cosmic.webp',
  };
}
