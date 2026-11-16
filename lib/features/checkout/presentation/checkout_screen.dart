import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../cart/domain/cart_item.dart';
import '../../cart/presentation/providers/cart_provider.dart';
import '../../profile/presentation/providers/profile_providers.dart';
import '../domain/checkout_options.dart';
import 'order_success_screen.dart';
import 'providers/checkout_provider.dart';
import 'widgets/address_selector.dart';
import 'widgets/checkout_section.dart';
import 'widgets/checkout_summary.dart';
import 'widgets/delivery_options.dart';
import 'widgets/payment_section.dart';
import 'widgets/promo_field.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _cardFormKey = GlobalKey<FormState>();
  bool _placing = false;

  List<CartItem>? _frozenItems;
  CheckoutTotals? _frozenTotals;

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _placeOrder() async {
    if (_placing) return;

    final address = ref.read(checkoutAddressProvider);
    final delivery = ref.read(deliveryMethodProvider);
    final payment = ref.read(paymentMethodProvider);

    if (address == null) {
      _showMessage('Please add a shipping address to continue.');
      return;
    }
    if (payment == PaymentMethod.card &&
        !(_cardFormKey.currentState?.validate() ?? false)) {
      _showMessage('Please check your card details.');
      return;
    }

    final items = ref.read(cartProvider);
    final totals = ref.read(checkoutTotalsProvider);
    setState(() {
      _placing = true;
      _frozenItems = items;
      _frozenTotals = totals;
    });

    await Future<void>.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    final order = ref.read(ordersProvider.notifier).placeOrder(
          itemCount: items.fold(0, (sum, i) => sum + i.quantity),
          total: totals.total,
        );
    ref.read(cartProvider.notifier).clear();
    ref.read(promoProvider.notifier).clear();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => OrderSuccessScreen(
          order: order,
          address: address,
          delivery: delivery,
          payment: payment,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final liveItems = ref.watch(cartProvider);
    final liveTotals = ref.watch(checkoutTotalsProvider);
    final items = _frozenItems ?? liveItems;
    final totals = _frozenTotals ?? liveTotals;

    if (items.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_bag_outlined,
                  size: 56, color: theme.colorScheme.outline),
              const SizedBox(height: 12),
              Text('Your cart is empty', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              AppButton(
                label: 'Back to cart',
                expand: false,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          CheckoutSection(
            title: 'Shipping address',
            icon: Icons.location_on_outlined,
            action: TextButton(
              onPressed: () => addAddressAndSelect(context, ref),
              child: const Text('Add new'),
            ),
            child: const AddressSelector(),
          ),
          const SizedBox(height: 12),
          const CheckoutSection(
            title: 'Delivery method',
            icon: Icons.local_shipping_outlined,
            child: DeliveryOptions(),
          ),
          const SizedBox(height: 12),
          CheckoutSection(
            title: 'Payment method',
            icon: Icons.payment_rounded,
            child: PaymentSection(cardFormKey: _cardFormKey),
          ),
          const SizedBox(height: 12),
          const CheckoutSection(
            title: 'Promo code',
            icon: Icons.local_offer_outlined,
            child: PromoField(),
          ),
          const SizedBox(height: 12),
          CheckoutSection(
            title: 'Order summary',
            icon: Icons.receipt_long_outlined,
            child: CheckoutSummary(items: items, totals: totals),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border:
              Border(top: BorderSide(color: theme.colorScheme.outlineVariant)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                    Text(
                      formatMoney(totals.total),
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    label: 'Place order',
                    icon: Icons.lock_outline_rounded,
                    loading: _placing,
                    onPressed: _placeOrder,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
