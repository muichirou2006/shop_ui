import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/domain/product_sort.dart';

/// Selected category slug; null means "All".
class SelectedCategoryNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void select(String? slug) => state = slug;
}

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void set(String query) => state = query;
}

class SortNotifier extends Notifier<ProductSort> {
  @override
  ProductSort build() => ProductSort.newest;

  void set(ProductSort sort) => state = sort;
}

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, String?>(SelectedCategoryNotifier.new);

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

final sortProvider = NotifierProvider<SortNotifier, ProductSort>(SortNotifier.new);
