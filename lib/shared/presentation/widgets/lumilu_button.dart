import 'package:flutter/material.dart';

import '../../../core/theme/lumilu_theme.dart';

class LumiluButton extends StatelessWidget {
  const LumiluButton({
    required this.label,
    required this.onPressed,
    this.filled = true,
    this.loading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool filled;
  final bool loading;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: filled
            ? [
                BoxShadow(
                  color: LumiluColors.yellow500.withValues(alpha: 0.32),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: LumiluColors.twilight900.withValues(alpha: 0.10),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: Ink(
          height: 60,
          decoration: BoxDecoration(
            color: filled ? null : Colors.transparent,
            gradient: filled
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [LumiluColors.yellow400, LumiluColors.yellow500],
                  )
                : null,
            border: filled
                ? null
                : Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? LumiluColors.yellow500
                        : LumiluColors.twilight800,
                    width: 1.5,
                  ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: loading ? null : onPressed,
            borderRadius: BorderRadius.circular(20),
            splashColor: filled
                ? LumiluColors.neutral0.withValues(alpha: 0.28)
                : LumiluColors.yellow500.withValues(alpha: 0.16),
            highlightColor: LumiluColors.twilight900.withValues(alpha: 0.06),
            child: Center(
              child: loading
                  ? const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: LumiluColors.twilight900,
                      ),
                    )
                  : Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: filled
                            ? LumiluColors.twilight900
                            : Theme.of(context).brightness == Brightness.dark
                            ? LumiluColors.yellow500
                            : LumiluColors.twilight800,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ),
      ),
    ),
  );
}
