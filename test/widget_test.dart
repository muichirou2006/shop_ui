import 'package:flutter_test/flutter_test.dart';
import 'package:shop_ui/features/product/domain/product.dart';

void main() {
  test('Product.fromJson maps the API response', () {
    final product = Product.fromJson(const {
      'id': 1,
      'title': 'Nova X1 Smartphone 256GB',
      'description': 'A phone.',
      'price': 799.0,
      'discount_price': 749.0,
      'category': {'id': 7, 'name': 'Smartphones', 'slug': 'smartphones'},
      'brand': 'Nova',
      'stock': 42,
      'ratings': 4.6,
      'review_count': 1280,
      'images': ['https://example.com/1.jpg'],
      'status': 'active',
      'attributes': {
        'storage': '256GB',
        'color': ['Black', 'Silver'],
      },
    });

    expect(product.id, '1');
    expect(product.effectivePrice, 749.0);
    expect(product.hasDiscount, true);
    expect(product.discountPercent, 6);
    expect(product.colors, ['Black', 'Silver']);
    expect(product.isOutOfStock, false);
    expect(product.specifications.containsKey('color'), false);
  });
}
