import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/presentation/providers/cart_provider.dart';
import '../../product/domain/product_sort.dart';
import '../../product/presentation/providers/product_providers.dart';
import '../../shell/presentation/providers/nav_provider.dart';
import 'providers/home_providers.dart';
import 'providers/product_list_provider.dart';
import 'widgets/category_chips.dart';
import 'widgets/product_grid.dart';
import 'widgets/promo_carousel.dart';
import '../../../l10n/l10n.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  bool _searching = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  /// Wait for the user to stop typing before calling the API.
  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 400),
      () => ref.read(searchQueryProvider.notifier).set(value),
    );
  }

  void _toggleSearch() {
    setState(() => _searching = !_searching);
    if (!_searching) {
      _debounce?.cancel();
      _searchController.clear();
      ref.read(searchQueryProvider.notifier).set('');
    }
  }

  /// Infinite scroll: ask for the next page when near the bottom.
  bool _onScroll(ScrollNotification notification) {
    if (notification.metrics.axis == Axis.vertical &&
        notification.metrics.extentAfter < 400) {
      ref.read(productListProvider.notifier).loadMore();
    }
    return false;
  }

  Future<void> _refresh() async {
    ref.invalidate(categoriesProvider);
    ref.invalidate(productListProvider);
    try {
      await ref.read(productListProvider.future);
    } catch (_) {
      // The error state is rendered by ProductsSliver.
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartCount = ref.watch(cartCountProvider);
    final total =
        ref.watch(productListProvider.select((s) => s.valueOrNull?.total));
    final sort = ref.watch(sortProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  toolbarHeight: 68,
                  titleSpacing: 16,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  title: _searching
                      ? TextField(
                          controller: _searchController,
                          autofocus: true,
                          textInputAction: TextInputAction.search,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            hintText: context.l10n.searchHint,
                            prefixIcon: const Icon(Icons.search_rounded),
                          ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.l10n.homeTitle,
                              style: theme.textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            Text(
                              context.l10n.homeSubtitle,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                  actions: [
                    IconButton(
                      tooltip: _searching
                          ? context.l10n.closeSearchTooltip
                          : context.l10n.searchTooltip,
                      onPressed: _toggleSearch,
                      icon: Icon(_searching
                          ? Icons.close_rounded
                          : Icons.search_rounded),
                    ),
                    if (!_searching)
                      IconButton(
                        tooltip: context.l10n.cartTooltip,
                        onPressed: () => ref
                            .read(navIndexProvider.notifier)
                            .set(NavTab.cart),
                        icon: Badge.count(
                          count: cartCount,
                          isLabelVisible: cartCount > 0,
                          child: const Icon(Icons.shopping_bag_outlined),
                        ),
                      ),
                    const SizedBox(width: 8),
                  ],
                ),
                if (!_searching)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 16),
                      child: PromoCarousel(),
                    ),
                  ),
                const SliverToBoxAdapter(child: CategoryChips()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 8, 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.l10n.productsTitle,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        if (total != null)
                          Text(
                            context.l10n.itemsCount(total),
                            style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant),
                          ),
                        PopupMenuButton<ProductSort>(
                          tooltip: context.l10n.sortTooltip,
                          icon: const Icon(Icons.swap_vert_rounded),
                          initialValue: sort,
                          onSelected: ref.read(sortProvider.notifier).set,
                          itemBuilder: (_) => [
                            for (final s in ProductSort.values)
                              PopupMenuItem(
                                value: s,
                                child: Text(s.localizedLabel(context.l10n)),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const ProductsSliver(),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
