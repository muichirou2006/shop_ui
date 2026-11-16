import 'package:flutter/material.dart';

const _categoryIcons = <String, IconData>{
  'electronics': Icons.headphones_rounded,
  'fashion': Icons.checkroom_rounded,
  'groceries': Icons.local_grocery_store_rounded,
  'furniture': Icons.chair_rounded,
  'appliances': Icons.kitchen_rounded,
  'sports': Icons.sports_soccer_rounded,
};

@immutable
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.slug,
    this.children = const [],
  });

  final int id;
  final String name;
  final String slug;
  final List<Category> children;

  IconData get icon => _categoryIcons[slug] ?? Icons.category_outlined;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int,
        name: json['name'] as String,
        slug: json['slug'] as String,
        children: (json['children'] as List? ?? const [])
            .map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
