import 'package:flutter/material.dart';

enum AppButtonVariant { filled, tonal, outlined }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.filled,
    this.expand = true,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;

  /// When true the button fills the available width (theme default).
  final bool expand;

  /// Shows a spinner and ignores taps while true.
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final spinnerColor = switch (variant) {
      AppButtonVariant.filled => scheme.onPrimary,
      AppButtonVariant.tonal => scheme.onSecondaryContainer,
      AppButtonVariant.outlined => scheme.primary,
    };

    final child = loading
        ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
            ],
          );

    final style = expand
        ? null
        : const ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(0, 52)));

    // While loading the button keeps its look but ignores taps.
    final VoidCallback? handler = loading ? () {} : onPressed;

    switch (variant) {
      case AppButtonVariant.filled:
        return FilledButton(onPressed: handler, style: style, child: child);
      case AppButtonVariant.tonal:
        return FilledButton.tonal(
            onPressed: handler, style: style, child: child);
      case AppButtonVariant.outlined:
        return OutlinedButton(onPressed: handler, style: style, child: child);
    }
  }
}
