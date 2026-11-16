import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../product/presentation/widgets/product_card.dart';
import '../providers/product_list_provider.dart';
import '../../../../l10n/l10n.dart';

// Responsive: 2 columns on phones, more on tablets.
const _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 240,
  mainAxisExtent: 292,
  crossAxisSpacing: 12,
  mainAxisSpacing: 12,
);

/// Sliver that shows loading / error / empty / data states for the product list.
class ProductsSliver extends ConsumerWidget {
  const ProductsSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(productListProvider);

    return async.when(
      loading: () => const _GridSkeleton(),
      error: (error, _) => SliverToBoxAdapter(
        child: ErrorView(
          message: error is ApiException
              ? (error.statusCode == null
                  ? context.l10n.errorNetwork
                  : error.message)
              : context.l10n.errorGeneric,
          onRetry: () => ref.invalidate(productListProvider),
        ),
      ),
      data: (state) {
        if (state.items.isEmpty) {
          return const SliverToBoxAdapter(child: _EmptyState());
        }

        return SliverMainAxisGroup(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid.builder(
                gridDelegate: _gridDelegate,
                itemCount: state.items.length,
                itemBuilder: (_, i) => ProductCard(product: state.items[i]),
              ),
            ),
            SliverToBoxAdapter(child: _Footer(state: state)),
          ],
        );
      },
    );
  }
}

class _Footer extends ConsumerWidget {
  const _Footer({required this.state});

  final ProductListState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.loadMoreError != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              context.l10n.loadMoreFailed,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            TextButton(
              onPressed: ref.read(productListProvider.notifier).retryLoadMore,
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      );
    }

    return const SizedBox(height: 8);
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          Icon(Icons.search_off_rounded,
              size: 56, color: theme.colorScheme.outline),
          const SizedBox(height: 12),
          Text(
            context.l10n.noProductsTitle,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.noProductsMessage,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _GridSkeleton extends StatelessWidget {
  const _GridSkeleton();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid.builder(
        gridDelegate: _gridDelegate,
        itemCount: 6,
        itemBuilder: (_, __) => const _SkeletonCard(),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;

    Widget bar(double width) => Container(
          width: width,
          height: 12,
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(6)),
        );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ColoredBox(color: color, child: const SizedBox.expand())),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [bar(110), bar(70), bar(50)],
            ),
          ),
        ],
      ),
    );
  }
}
