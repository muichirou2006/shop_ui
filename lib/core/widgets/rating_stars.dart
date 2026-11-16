import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.reviewCount,
    this.size = 16,
  });

  final double rating;
  final int? reviewCount;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, size: size, color: AppColors.star),
        const SizedBox(width: 2),
        Text(
          rating.toStringAsFixed(1),
          style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        if (reviewCount != null)
          Text(
            ' ($reviewCount)',
            style: theme.textTheme.labelMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
      ],
    );
  }
}
