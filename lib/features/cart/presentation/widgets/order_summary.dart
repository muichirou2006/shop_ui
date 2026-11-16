import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../checkout/presentation/checkout_screen.dart';
import '../providers/cart_provider.dart';
import '../../../../l10n/l10n.dart';

class OrderSummary extends ConsumerWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final subtotal = ref.watch(cartSubtotalProvider);
    final shipping = ref.watch(cartShippingProvider);
    final total = ref.watch(cartTotalProvider);
    final remainingForFree = kFreeShippingThreshold - subtotal;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SummaryRow(
                label: context.l10n.subtotal, value: formatMoney(subtotal)),
            const SizedBox(height: 8),
            _SummaryRow(
              label: context.l10n.shipping,
              value: shipping == 0 ? context.l10n.free : formatMoney(shipping),
            ),
            if (remainingForFree > 0) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.freeShippingHint(formatMoney(remainingForFree)),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            _SummaryRow(
                label: context.l10n.total,
                value: formatMoney(total),
                emphasized: true),
            const SizedBox(height: 16),
            AppButton(
              label: context.l10n.checkout,
              icon: Icons.lock_outline_rounded,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CheckoutScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = emphasized
        ? theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)
        : theme.textTheme.bodyLarge
            ?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(
          value,
          style: emphasized
              ? style
              : theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
