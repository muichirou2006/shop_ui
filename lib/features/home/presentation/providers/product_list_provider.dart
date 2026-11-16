import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../product/data/product_repository.dart';
import '../../../product/domain/product.dart';
import '../../../product/domain/product_sort.dart';
import '../../../product/presentation/providers/product_providers.dart';
import 'home_providers.dart';

@immutable
class ProductListState {
  const ProductListState({
    required this.items,
    required this.page,
    required this.totalPages,
    required this.total,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<Product> items;
  final int page;
  final int totalPages;
  final int total;
  final bool isLoadingMore;
  final String? loadMoreError;

  bool get hasMore => page < totalPages;

  ProductListState copyWith({
    List<Product>? items,
    int? page,
    int? totalPages,
    int? total,
    bool? isLoadingMore,
    String? loadMoreError,
    bool clearError = false,
  }) {
    return ProductListState(
      items: items ?? this.items,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      total: total ?? this.total,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError: clearError ? null : (loadMoreError ?? this.loadMoreError),
    );
  }
}

/// Loads page 1 whenever the category, search query or sort changes,
/// and appends further pages through [loadMore] (infinite scroll).
class ProductListNotifier extends AsyncNotifier<ProductListState> {
  static const _pageSize = 10;

  int _generation = 0; // detects results that belong to outdated filters
  String? _category;
  String _query = '';
  ProductSort _sort = ProductSort.newest;

  @override
  Future<ProductListState> build() async {
    _generation++;
    // Everything that must trigger a reload is watched before the first await.
    _category = ref.watch(selectedCategoryProvider);
    _query = ref.watch(searchQueryProvider).trim();
    _sort = ref.watch(sortProvider);

    final result = await _fetchPage(1);
    return ProductListState(
      items: result.items,
      page: result.page,
      totalPages: result.totalPages,
      total: result.total,
    );
  }

  Future<PagedProducts> _fetchPage(int page) {
    return ref.read(productRepositoryProvider).fetchProducts(
          page: page,
          limit: _pageSize,
          query: _query,
          categorySlug: _category,
          sort: _sort,
        );
  }

  Future<void> loadMore() async {
    if (state.isLoading) return; // initial load / reload in progress
    final current = state.valueOrNull;
    if (current == null ||
        current.isLoadingMore ||
        !current.hasMore ||
        current.loadMoreError != null) {
      return;
    }

    final generation = _generation;
    state = AsyncData(current.copyWith(isLoadingMore: true, clearError: true));

    try {
      final next = await _fetchPage(current.page + 1);
      if (generation != _generation) return;
      state = AsyncData(current.copyWith(
        items: [...current.items, ...next.items],
        page: next.page,
        totalPages: next.totalPages,
        total: next.total,
        isLoadingMore: false,
      ));
    } catch (e) {
      if (generation != _generation) return;
      state = AsyncData(current.copyWith(
        isLoadingMore: false,
        loadMoreError: e is ApiException ? e.message : 'Could not load more products.',
      ));
    }
  }

  void retryLoadMore() {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(current.copyWith(clearError: true));
    loadMore();
  }
}

final productListProvider =
    AsyncNotifierProvider<ProductListNotifier, ProductListState>(ProductListNotifier.new);
