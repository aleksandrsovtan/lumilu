import 'package:flutter/material.dart';

import '../models/lumi_body.dart';
import '../models/lumi_hat.dart';

class LumiChar extends StatelessWidget {
  const LumiChar({
    required this.selectedBody,
    required this.selectedHat,
    super.key,
  });

  final LumiBody selectedBody;
  final LumiHat? selectedHat;

  @override
  Widget build(BuildContext context) {
    final characterSize = MediaQuery.sizeOf(context).height * 0.30;

    return SizedBox.square(
      dimension: characterSize,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
            child: Image.asset(
              selectedBody.assetPath,
              key: Key('${selectedBody.name}-lumi-image'),
              fit: BoxFit.contain,
            ),
          ),
          if (selectedHat case final hat?)
            Transform.translate(
              offset: Offset(-4, -characterSize * 0.2),
              child: SizedBox.square(
                dimension: characterSize * 0.65,
                child: Image.asset(
                  hat.assetPath,
                  key: Key('lumi-${hat.name}-hat-image'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
