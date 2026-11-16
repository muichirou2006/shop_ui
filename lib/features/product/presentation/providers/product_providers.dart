import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../../../data/mock/mock_banners.dart';
import '../../data/product_repository.dart';
import '../../domain/category.dart';
import '../../domain/product.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ApiClient();
  ref.onDispose(client.dispose);
  return client;
});

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepository(ref.watch(apiClientProvider)),
);

/// Parent categories (each with `children`) from GET /categories.
final categoriesProvider = FutureProvider<List<Category>>(
  (ref) => ref.watch(productRepositoryProvider).fetchCategories(),
);

/// Fresh details for one product (GET /products/:id).
final productDetailProvider = FutureProvider.autoDispose.family<Product, String>(
  (ref, id) => ref.watch(productRepositoryProvider).fetchProduct(id),
);

/// Promo banners are static content (the API has no banner endpoint).
final bannersProvider = Provider<List<PromoBanner>>((ref) => mockBanners);
