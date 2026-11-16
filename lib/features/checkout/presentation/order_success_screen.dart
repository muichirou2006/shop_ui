import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../profile/domain/address.dart';
import '../../profile/domain/order.dart';
import '../../shell/presentation/providers/nav_provider.dart';
import '../domain/checkout_options.dart';

class OrderSuccessScreen extends ConsumerWidget {
  const OrderSuccessScreen({
    super.key,
    required this.order,
    required this.address,
    required this.delivery,
    required this.payment,
  });

  final Order order;
  final Address address;
  final DeliveryMethod delivery;
  final PaymentMethod payment;

  void _goTo(BuildContext context, WidgetRef ref, int tab) {
    ref.read(navIndexProvider.notifier).set(tab);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goTo(context, ref, NavTab.home);
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
            children: [
              Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.elasticOut,
                  builder: (_, value, child) =>
                      Transform.scale(scale: value, child: child),
                  child: Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded,
                        size: 60, color: AppColors.success),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Order placed!',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                'Thank you for your purchase. We will send you updates as your order is prepared.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 28),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _DetailRow(label: 'Order number', value: '#${order.id}'),
                      const Divider(height: 24),
                      _DetailRow(
                          label: 'Total paid', value: formatMoney(order.total)),
                      const Divider(height: 24),
                      _DetailRow(
                        label: 'Delivery',
                        value: '${delivery.title}\n${delivery.eta}',
                      ),
                      const Divider(height: 24),
                      _DetailRow(
                        label: 'Ship to',
                        value:
                            '${address.recipient}\n${address.street}, ${address.city}',
                      ),
                      const Divider(height: 24),
                      _DetailRow(label: 'Payment', value: payment.title),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              AppButton(
                label: 'View my orders',
                icon: Icons.inventory_2_outlined,
                onPressed: () => _goTo(context, ref, NavTab.profile),
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Continue shopping',
                variant: AppButtonVariant.outlined,
                onPressed: () => _goTo(context, ref, NavTab.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
