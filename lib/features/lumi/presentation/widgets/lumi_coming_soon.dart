import 'package:flutter/material.dart';

class LumiComingSoon extends StatelessWidget {
  const LumiComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Скоро буде…',
        key: const Key('lumi-coming-soon'),
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
