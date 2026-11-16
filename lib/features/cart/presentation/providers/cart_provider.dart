import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/domain/product.dart';
import '../../domain/cart_item.dart';

const kFreeShippingThreshold = 100.0;
const kFlatShipping = 7.99;

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => const [];

  /// Adds a product; merges quantities if the same variant already exists.
  void add(Product product, {String? size, String? color, int quantity = 1}) {
    final incoming = CartItem(
      product: product,
      size: size,
      color: color,
      quantity: quantity,
    );
    final index = state.indexWhere((i) => i.lineId == incoming.lineId);

    if (index == -1) {
      state = [...state, incoming];
    } else {
      final existing = state[index];
      state = [
        for (var i = 0; i < state.length; i++)
          if (i == index)
            existing.copyWith(quantity: existing.quantity + quantity)
          else
            state[i],
      ];
    }
  }

  void increment(String lineId) => _updateQuantity(lineId, 1);

  /// Decrementing from 1 removes the line.
  void decrement(String lineId) => _updateQuantity(lineId, -1);

  void remove(String lineId) {
    state = state.where((i) => i.lineId != lineId).toList();
  }

  void clear() => state = const [];

  void _updateQuantity(String lineId, int delta) {
    state = [
      for (final item in state)
        if (item.lineId == lineId)
          item.copyWith(quantity: item.quantity + delta)
        else
          item,
    ].where((i) => i.quantity > 0).toList();
  }
}

final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);

/// Total number of units (for the nav-bar badge).
final cartCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).fold(0, (sum, i) => sum + i.quantity);
});

final cartSubtotalProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).fold(0.0, (sum, i) => sum + i.lineTotal);
});

final cartShippingProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  return subtotal == 0 || subtotal >= kFreeShippingThreshold ? 0 : kFlatShipping;
});

final cartTotalProvider = Provider<double>((ref) {
  return ref.watch(cartSubtotalProvider) + ref.watch(cartShippingProvider);
});
