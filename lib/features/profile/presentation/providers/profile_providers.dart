import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/address.dart';
import '../../domain/order.dart';

class OrdersNotifier extends Notifier<List<Order>> {
  @override
  List<Order> build() {
    final now = DateTime.now();
    return [
      Order(
        id: 'SH-10482',
        date: now.subtract(const Duration(days: 2)),
        total: 114.98,
        itemCount: 2,
        status: OrderStatus.shipped,
      ),
      Order(
        id: 'SH-10377',
        date: now.subtract(const Duration(days: 14)),
        total: 59.50,
        itemCount: 1,
        status: OrderStatus.delivered,
      ),
      Order(
        id: 'SH-10211',
        date: now.subtract(const Duration(days: 41)),
        total: 238.00,
        itemCount: 3,
        status: OrderStatus.delivered,
      ),
    ];
  }

  /// Adds a new order at the top of the history (local only for now).
  Order placeOrder({required int itemCount, required double total}) {
    final order = Order(
      id: 'SH-${10000 + Random().nextInt(89999)}',
      date: DateTime.now(),
      total: total,
      itemCount: itemCount,
      status: OrderStatus.processing,
    );
    state = [order, ...state];
    return order;
  }
}

final ordersProvider =
    NotifierProvider<OrdersNotifier, List<Order>>(OrdersNotifier.new);

class AddressesNotifier extends Notifier<List<Address>> {
  @override
  List<Address> build() => const [
        Address(
          id: 'a1',
          label: 'Home',
          recipient: 'Alex Morgan',
          street: '12 Riverside Avenue',
          city: 'Phnom Penh',
          isDefault: true,
        ),
        Address(
          id: 'a2',
          label: 'Work',
          recipient: 'Alex Morgan',
          street: '88 Business Park, Floor 4',
          city: 'Phnom Penh',
        ),
      ];

  Address add({
    required String label,
    required String recipient,
    required String street,
    required String city,
  }) {
    final address = Address(
      id: 'a${DateTime.now().microsecondsSinceEpoch}',
      label: label,
      recipient: recipient,
      street: street,
      city: city,
      isDefault: state.isEmpty,
    );
    state = [...state, address];
    return address;
  }

  void remove(String id) {
    final wasDefault = state.any((a) => a.id == id && a.isDefault);
    final next = state.where((a) => a.id != id).toList();
    if (wasDefault && next.isNotEmpty) {
      next[0] = next[0].copyWith(isDefault: true);
    }
    state = next;
  }

  void makeDefault(String id) {
    state = [for (final a in state) a.copyWith(isDefault: a.id == id)];
  }
}

final addressesProvider =
    NotifierProvider<AddressesNotifier, List<Address>>(AddressesNotifier.new);
