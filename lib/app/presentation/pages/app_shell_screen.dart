import 'package:flutter/material.dart';

import '../widgets/main_bottom_navigation.dart';
import '../widgets/main_header.dart';

class AppShellScreen extends StatelessWidget {
  const AppShellScreen({
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.onOpenProfile,
    super.key,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          MainHeader(onOpenProfile: onOpenProfile),
          Expanded(child: body),
        ],
      ),
    ),
    bottomNavigationBar: MainBottomNavigation(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    ),
  );
}
