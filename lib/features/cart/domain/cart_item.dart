import 'package:flutter/foundation.dart';

import '../../product/domain/product.dart';

@immutable
class CartItem {
  const CartItem({
    required this.product,
    this.size,
    this.color,
    this.quantity = 1,
  });

  final Product product;
  final String? size;
  final String? color;
  final int quantity;

  /// Same product with a different variant is a separate cart line.
  String get lineId => '${product.id}|${size ?? '-'}|${color ?? '-'}';

  double get lineTotal => product.effectivePrice * quantity;

  CartItem copyWith({int? quantity}) => CartItem(
        product: product,
        size: size,
        color: color,
        quantity: quantity ?? this.quantity,
      );
}
