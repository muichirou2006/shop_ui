import 'package:flutter/foundation.dart';

@immutable
class Product {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.categoryId,
    this.discountPrice,
    this.categoryName = '',
    this.brand = '',
    this.stock = 0,
    this.status = 'active',
    this.images = const [],
    this.attributes = const <String, dynamic>{},
    this.sizes = const [],
    this.colors = const [],
  });

  final String id;
  final String title;
  final String description;

  /// Regular price. See [effectivePrice] for what the customer pays.
  final double price;
  final double? discountPrice;
  final double rating;
  final int reviewCount;
  final String imageUrl;

  /// Category slug (the API filters by slug).
  final String categoryId;
  final String categoryName;
  final String brand;
  final int stock;
  final String status;
  final List<String> images;

  /// Raw dynamic attributes from the API (size, color, wattage, weight, ...).
  final Map<String, dynamic> attributes;
  final List<String> sizes;
  final List<String> colors;

  bool get hasDiscount => discountPrice != null && discountPrice! < price;
  double get effectivePrice => hasDiscount ? discountPrice! : price;
  int get discountPercent =>
      hasDiscount ? (((price - discountPrice!) / price) * 100).round() : 0;
  bool get isOutOfStock => status == 'out_of_stock' || stock <= 0;

  /// Attributes shown in the "Specifications" table (size/color have selectors).
  Map<String, dynamic> get specifications => {
        for (final e in attributes.entries)
          if (e.key != 'size' && e.key != 'color') e.key: e.value,
      };

  factory Product.fromJson(Map<String, dynamic> json) {
    final attributes = Map<String, dynamic>.from(json['attributes'] as Map? ?? const {});
    final images = (json['images'] as List? ?? const []).map((e) => e.toString()).toList();
    final category = json['category'] as Map<String, dynamic>?;

    return Product(
      id: json['id'].toString(),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discount_price'] as num?)?.toDouble(),
      rating: (json['ratings'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      imageUrl: images.isNotEmpty ? images.first : '',
      images: images,
      categoryId: category?['slug'] as String? ?? '',
      categoryName: category?['name'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'active',
      attributes: attributes,
      sizes: _stringList(attributes['size']),
      colors: _stringList(attributes['color']),
    );
  }
}

List<String> _stringList(Object? value) {
  if (value is List) return value.map((e) => e.toString()).toList();
  if (value is String && value.isNotEmpty) return [value];
  return const [];
}
