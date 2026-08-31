enum LumiBody { base, berry, cloud, cosmic, flame, gold, mystery, ocean }

extension LumiBodyAsset on LumiBody {
  String get assetPath => switch (this) {
    LumiBody.base => 'assets/images/lumi_tab/body/body_base.webp',
    LumiBody.berry => 'assets/images/lumi_tab/body/body_berry.webp',
    LumiBody.cloud => 'assets/images/lumi_tab/body/body_cloud.webp',
    LumiBody.cosmic => 'assets/images/lumi_tab/body/body_cosmic.webp',
    LumiBody.flame => 'assets/images/lumi_tab/body/body_flame.webp',
    LumiBody.gold => 'assets/images/lumi_tab/body/body_gold.webp',
    LumiBody.mystery => 'assets/images/lumi_tab/body/body_mystery.webp',
    LumiBody.ocean => 'assets/images/lumi_tab/body/body_ocean.webp',
  };
}
