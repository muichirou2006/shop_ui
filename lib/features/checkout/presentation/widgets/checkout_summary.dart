import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/network_image_box.dart';
import '../../../cart/domain/cart_item.dart';
import '../providers/checkout_provider.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({super.key, required this.items, required this.totals});

  final List<CartItem> items;
  final CheckoutTotals totals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                NetworkImageBox(
                  url: item.product.imageUrl,
                  width: 52,
                  height: 52,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm - 2),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        [
                          if (item.size != null) item.size!,
                          if (item.color != null) item.color!,
                          'Qty ${item.quantity}',
                        ].join('  ·  '),
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  formatMoney(item.lineTotal),
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        const Divider(height: 24),
        _Row(label: 'Subtotal', value: formatMoney(totals.subtotal)),
        if (totals.discount > 0) ...[
          const SizedBox(height: 8),
          _Row(
            label: 'Promo discount',
            value: '-${formatMoney(totals.discount)}',
            valueColor: AppColors.success,
          ),
        ],
        const SizedBox(height: 8),
        _Row(
          label: 'Delivery',
          value: totals.delivery == 0 ? 'Free' : formatMoney(totals.delivery),
        ),
        const Divider(height: 24),
        _Row(
            label: 'Total', value: formatMoney(totals.total), emphasized: true),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    this.emphasized = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool emphasized;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = emphasized
        ? theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)
        : theme.textTheme.bodyMedium
            ?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    final valueStyle =
        (emphasized ? theme.textTheme.titleMedium : theme.textTheme.bodyMedium)
            ?.copyWith(fontWeight: FontWeight.w700, color: valueColor);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelStyle),
        Text(value, style: valueStyle)
      ],
    );
  }
}
