import 'package:flutter/material.dart';

class LumiluPlaceholderPage extends StatelessWidget {
  const LumiluPlaceholderPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.accent,
    this.action,
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color accent;
  final Widget? action;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
    child: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 480),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.22),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 46, color: accent),
                ),
                const SizedBox(height: 26),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          if (action != null) ...[const SizedBox(height: 24), action!],
        ],
      ),
    ),
  );
}
