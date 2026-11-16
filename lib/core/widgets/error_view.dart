import 'package:flutter/material.dart';
import '../../l10n/l10n.dart';

import 'app_button.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_off_rounded,
              size: 56, color: theme.colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            context.l10n.errorTitle,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          AppButton(
            label: context.l10n.tryAgain,
            icon: Icons.refresh_rounded,
            variant: AppButtonVariant.tonal,
            expand: false,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
