enum LumiClothing { premium, futuristic, holographic, ocean }

extension LumiClothingAsset on LumiClothing {
  String get assetPath => switch (this) {
    LumiClothing.premium =>
      'assets/images/lumi_tab/clothing/clothing_premium.webp',
    LumiClothing.futuristic =>
      'assets/images/lumi_tab/clothing/clothing_futuristic.webp',
    LumiClothing.holographic =>
      'assets/images/lumi_tab/clothing/clothing_holographic.webp',
    LumiClothing.ocean => 'assets/images/lumi_tab/clothing/clothing_ocean.webp',
  };
}
