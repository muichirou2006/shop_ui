import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../profile/domain/address.dart';
import '../../../profile/presentation/providers/profile_providers.dart';
import '../../domain/checkout_options.dart';

const kExpressShipping = 12.99;
const kPromoCode = 'SAVE10'; // demo code: 10% off the subtotal
const kPromoRate = 0.10;

/// Standard delivery is free above [kFreeShippingThreshold]; express is a flat fee.
double deliveryFee(DeliveryMethod method, double subtotal) {
  if (subtotal <= 0) return 0.0;
  return switch (method) {
    DeliveryMethod.standard =>
      subtotal >= kFreeShippingThreshold ? 0.0 : kFlatShipping,
    DeliveryMethod.express => kExpressShipping,
  };
}

class DeliveryMethodNotifier extends Notifier<DeliveryMethod> {
  @override
  DeliveryMethod build() => DeliveryMethod.standard;

  void select(DeliveryMethod method) => state = method;
}

class PaymentMethodNotifier extends Notifier<PaymentMethod> {
  @override
  PaymentMethod build() => PaymentMethod.card;

  void select(PaymentMethod method) => state = method;
}

class SelectedAddressIdNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void select(String id) => state = id;
}

/// Currently applied promo code, or null.
class PromoNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  bool apply(String code) {
    if (code.trim().toUpperCase() == kPromoCode) {
      state = kPromoCode;
      return true;
    }
    return false;
  }

  void clear() => state = null;
}

final deliveryMethodProvider =
    NotifierProvider<DeliveryMethodNotifier, DeliveryMethod>(
        DeliveryMethodNotifier.new);

final paymentMethodProvider =
    NotifierProvider<PaymentMethodNotifier, PaymentMethod>(
        PaymentMethodNotifier.new);

final selectedAddressIdProvider =
    NotifierProvider<SelectedAddressIdNotifier, String?>(
        SelectedAddressIdNotifier.new);

final promoProvider =
    NotifierProvider<PromoNotifier, String?>(PromoNotifier.new);

/// The address used for this order: the one picked, else the default, else the first.
final checkoutAddressProvider = Provider<Address?>((ref) {
  final addresses = ref.watch(addressesProvider);
  if (addresses.isEmpty) return null;
  final selectedId = ref.watch(selectedAddressIdProvider);
  return addresses.firstWhere(
    (a) => a.id == selectedId,
    orElse: () =>
        addresses.firstWhere((a) => a.isDefault, orElse: () => addresses.first),
  );
});

@immutable
class CheckoutTotals {
  const CheckoutTotals({
    required this.subtotal,
    required this.discount,
    required this.delivery,
  });

  final double subtotal;
  final double discount;
  final double delivery;

  double get total => subtotal - discount + delivery;
}

final checkoutTotalsProvider = Provider<CheckoutTotals>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  final method = ref.watch(deliveryMethodProvider);
  final promo = ref.watch(promoProvider);

  final discount =
      promo == null ? 0.0 : (subtotal * kPromoRate * 100).round() / 100;
  return CheckoutTotals(
    subtotal: subtotal,
    discount: discount,
    delivery: deliveryFee(method, subtotal),
  );
});
