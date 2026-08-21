enum LumiHat { baseHat, capybara }

extension LumiHatAsset on LumiHat {
  String get assetPath => switch (this) {
    LumiHat.baseHat => 'assets/images/lumi_tab/head/hat_base.webp',
    LumiHat.capybara => 'assets/images/lumi_tab/head/hat_capybara.webp',
  };
}
