import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../domain/category.dart';
import '../domain/product.dart';
import '../domain/product_sort.dart';

class PagedProducts {
  const PagedProducts({
    required this.items,
    required this.page,
    required this.totalPages,
    required this.total,
  });

  final List<Product> items;
  final int page;
  final int totalPages;
  final int total;
}

class ProductRepository {
  ProductRepository(this._api);

  final ApiClient _api;

  static const _badResponse = 'Unexpected response from the server.';

  Future<PagedProducts> fetchProducts({
    int page = 1,
    int limit = 10,
    String query = '',
    String? categorySlug,
    ProductSort sort = ProductSort.newest,
  }) async {
    final json = await _api.get('/products', query: {
      'page': '$page',
      'limit': '$limit',
      if (query.isNotEmpty) 'q': query,
      if (categorySlug != null) 'category': categorySlug,
      'sort': sort.apiValue,
    });

    try {
      final meta = json['meta'] as Map<String, dynamic>;
      return PagedProducts(
        items: (json['data'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
        page: meta['page'] as int,
        totalPages: meta['total_pages'] as int,
        total: meta['total'] as int,
      );
    } on TypeError {
      throw ApiException(_badResponse);
    }
  }

  Future<Product> fetchProduct(String id) async {
    final json = await _api.get('/products/${Uri.encodeComponent(id)}');
    try {
      return Product.fromJson(json['data'] as Map<String, dynamic>);
    } on TypeError {
      throw ApiException(_badResponse);
    }
  }

  Future<List<Category>> fetchCategories() async {
    final json = await _api.get('/categories');
    try {
      return (json['data'] as List)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
    } on TypeError {
      throw ApiException(_badResponse);
    }
  }
}
