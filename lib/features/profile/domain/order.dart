import 'package:flutter/foundation.dart';

enum OrderStatus { processing, shipped, delivered }

@immutable
class Order {
  const Order({
    required this.id,
    required this.date,
    required this.total,
    required this.itemCount,
    required this.status,
  });

  final String id;
  final DateTime date;
  final double total;
  final int itemCount;
  final OrderStatus status;
}
