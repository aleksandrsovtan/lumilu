import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({required this.onOpenProfile, super.key});

  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
    child: SizedBox(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/lumilu.webp',
            key: const Key('lumilu-header-logo'),
            width: 112,
            height: 48,
            fit: BoxFit.contain,
            alignment: Alignment.centerLeft,
            semanticLabel: 'LUMILU',
          ),
          const Spacer(),
          IconButton.filledTonal(
            key: const Key('open-profile-settings'),
            onPressed: onOpenProfile,
            tooltip: AppLocalizations.of(context)!.profileSettingsTitle,
            style: IconButton.styleFrom(minimumSize: const Size.square(48), maximumSize: const Size.square(48)),
            icon: const Icon(Icons.person_outline_rounded),
          ),
        ],
      ),
    ),
  );
}
