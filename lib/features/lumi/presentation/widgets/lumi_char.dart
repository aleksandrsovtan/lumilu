import 'package:flutter/material.dart';

import '../models/lumi_body.dart';
import '../models/lumi_clothing.dart';
import '../models/lumi_hat.dart';

class LumiChar extends StatelessWidget {
  const LumiChar({required this.selectedBody, required this.selectedHat, required this.selectedClothing, super.key});

  final LumiBody selectedBody;
  final LumiHat? selectedHat;
  final LumiClothing? selectedClothing;

  @override
  Widget build(BuildContext context) {
    final characterSize = MediaQuery.sizeOf(context).height * 0.33;

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
          if (selectedClothing case final clothing?)
            Transform.translate(
              offset: Offset(0, characterSize * 0.3),
              child: SizedBox.square(
                dimension: characterSize * 0.7,
                child: Image.asset(
                  clothing.assetPath,
                  key: Key('lumi-${clothing.name}-clothing-image'),
                  fit: BoxFit.contain,
                ),
              ),
            ),

          if (selectedHat case final hat?)
            Transform.translate(
              offset: Offset(0, -characterSize * 0.125),
              child: SizedBox.square(
                dimension: characterSize,
                child: Image.asset(hat.assetPath, key: Key('lumi-${hat.name}-hat-image'), fit: BoxFit.contain),
              ),
            ),
        ],
      ),
    );
  }
}
