import 'package:flutter/material.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/quantity_selector.dart';

class DetailsBottomBar extends StatelessWidget {
  const DetailsBottomBar({
    super.key,
    required this.quantity,
    required this.unitPrice,
    required this.outOfStock,
    required this.onIncrement,
    required this.onDecrement,
    required this.onAddToCart,
  });

  final int quantity;
  final double unitPrice;
  final bool outOfStock;

  /// Pass null to disable (e.g. when the stock limit is reached).
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(top: BorderSide(color: theme.colorScheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: outOfStock
              ? const AppButton(label: 'Out of stock', onPressed: null)
              : Row(
                  children: [
                    QuantitySelector(
                      value: quantity,
                      onIncrement: onIncrement,
                      onDecrement: onDecrement,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppButton(
                        label: 'Add to Cart  ·  ${formatMoney(unitPrice * quantity)}',
                        icon: Icons.shopping_bag_outlined,
                        onPressed: onAddToCart,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
