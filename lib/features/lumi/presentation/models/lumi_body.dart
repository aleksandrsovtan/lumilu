enum LumiBody { placeholder, base }

extension LumiBodyAsset on LumiBody {
  String get assetPath => switch (this) {
    LumiBody.placeholder => 'assets/images/lumi_tab/body/lumi_placeholder.webp',
    LumiBody.base => 'assets/images/lumi_tab/body/lumi_base.webp',
  };
}
