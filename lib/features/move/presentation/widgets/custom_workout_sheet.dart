import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations_extension.dart';

Future<String?> showCustomWorkoutSheet(BuildContext context) =>
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const _CustomWorkoutSheet(),
    );

class _CustomWorkoutSheet extends StatefulWidget {
  const _CustomWorkoutSheet();
  @override
  State<_CustomWorkoutSheet> createState() => _CustomWorkoutSheetState();
}

class _CustomWorkoutSheetState extends State<_CustomWorkoutSheet> {
  late final TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.createWorkoutTitle,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.createWorkoutDescription,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              key: const Key('custom-workout-name'),
              controller: _nameController,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: context.l10n.workoutNameLabel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              key: const Key('create-custom-workout'),
              onPressed: _submit,
              icon: const Icon(Icons.add_rounded),
              label: Text(context.l10n.createWorkoutAction),
            ),
          ],
        ),
      ),
    ),
  );
  void _submit() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) Navigator.pop(context, name);
  }
}
