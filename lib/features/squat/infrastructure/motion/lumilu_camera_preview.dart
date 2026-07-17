import 'package:flutter/widgets.dart';
import 'package:lumilu_motion/lumilu_motion.dart';

class LumiluCameraPreview extends StatelessWidget {
  const LumiluCameraPreview({required this.detector, super.key});
  final LumiluMotionDetector detector;

  @override
  Widget build(BuildContext context) => LumiluCameraView(controller: detector);
}
