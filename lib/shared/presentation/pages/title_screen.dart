import 'package:flutter/material.dart';

import '../../../core/theme/lumilu_theme.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? LumiluColors.neutral0
                  : LumiluColors.twilight800,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    ),
  );
}
