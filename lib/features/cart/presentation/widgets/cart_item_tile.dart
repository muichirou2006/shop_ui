import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/network_image_box.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../../domain/cart_item.dart';
import '../providers/cart_provider.dart';
import '../../../../l10n/l10n.dart';

class CartItemTile extends ConsumerWidget {
  const CartItemTile({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final notifier = ref.read(cartProvider.notifier);
    final variant = [
      if (item.size != null) context.l10n.sizeLabel(item.size!),
      if (item.color != null) context.l10n.colorLabel(item.color!),
    ].join('  ·  ');

    return Dismissible(
      key: ValueKey(item.lineId),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => notifier.remove(item.lineId),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.circular(AppSpacing.radius),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              NetworkImageBox(
                url: item.product.imageUrl,
                width: 88,
                height: 88,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 88,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          InkResponse(
                            onTap: () => notifier.remove(item.lineId),
                            radius: 18,
                            child: Icon(
                              Icons.close_rounded,
                              size: 20,
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        variant.isEmpty ? ' ' : variant,
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatMoney(item.lineTotal),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          QuantitySelector(
                            compact: true,
                            value: item.quantity,
                            onIncrement: () => notifier.increment(item.lineId),
                            onDecrement: () => notifier.decrement(item.lineId),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
