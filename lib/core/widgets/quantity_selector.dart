import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    this.compact = false,
  });

  final int value;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = compact ? 32.0 : 44.0;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _RoundButton(icon: Icons.remove, size: size, compact: compact, onTap: onDecrement),
          SizedBox(
            width: compact ? 24 : 36,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: (compact ? theme.textTheme.labelLarge : theme.textTheme.titleMedium)
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          _RoundButton(icon: Icons.add, size: size, compact: compact, onTap: onIncrement),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.size,
    required this.compact,
    required this.onTap,
  });

  final IconData icon;
  final double size;
  final bool compact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: compact ? 16 : 20),
      padding: EdgeInsets.zero,
      constraints: BoxConstraints.tightFor(width: size, height: size),
    );
  }
}
