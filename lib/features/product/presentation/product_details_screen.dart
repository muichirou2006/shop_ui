import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/rating_stars.dart';
import '../../cart/presentation/providers/cart_provider.dart';
import '../../shell/presentation/providers/nav_provider.dart';
import '../domain/product.dart';
import 'providers/product_providers.dart';
import 'widgets/details_bottom_bar.dart';
import 'widgets/product_gallery.dart';
import 'widgets/specifications_card.dart';
import 'widgets/variant_selector.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  /// Preview shown instantly; fresh data is then loaded from GET /products/:id.
  final Product product;

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  String? _size;
  String? _color;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _size = widget.product.sizes.firstOrNull;
    _color = widget.product.colors.firstOrNull;
  }

  void _addToCart(Product product, String? size, String? color, int quantity) {
    ref.read(cartProvider.notifier).add(
          product,
          size: size,
          color: color,
          quantity: quantity,
        );

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Added $quantity × ${product.title}'),
          action: SnackBarAction(
            label: 'View cart',
            onPressed: () {
              ref.read(navIndexProvider.notifier).set(NavTab.cart);
              if (navigator.canPop()) navigator.pop();
            },
          ),
        ),
      );
    setState(() => _quantity = 1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Use fresh API data when it arrives; otherwise keep showing the preview.
    final detail = ref.watch(productDetailProvider(widget.product.id));
    final product = detail.valueOrNull ?? widget.product;

    // Keep selections valid if the refreshed product has different options.
    final size = product.sizes.contains(_size) ? _size : product.sizes.firstOrNull;
    final color = product.colors.contains(_color) ? _color : product.colors.firstOrNull;
    final quantity = product.stock > 0 ? math.min(_quantity, product.stock) : 1;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 380,
            backgroundColor: scheme.surface,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: scheme.surface.withValues(alpha: 0.9),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: ProductGallery(
                images: product.images,
                heroTag: 'product-${product.id}',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.brand.isNotEmpty) ...[
                    Text(
                      product.brand.toUpperCase(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: theme.textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _PriceBlock(product: product),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      RatingStars(
                        rating: product.rating,
                        reviewCount: product.reviewCount,
                        size: 20,
                      ),
                      const Spacer(),
                      _StockLabel(product: product),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  if (product.sizes.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    VariantSection(
                      title: 'Size',
                      child: SizeSelector(
                        sizes: product.sizes,
                        selected: size,
                        onSelected: (s) => setState(() => _size = s),
                      ),
                    ),
                  ],
                  if (product.colors.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    VariantSection(
                      title: 'Color: ${color ?? ''}',
                      child: ColorSelector(
                        colors: product.colors,
                        selected: color,
                        onSelected: (c) => setState(() => _color = c),
                      ),
                    ),
                  ],
                  if (product.specifications.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(
                      'Specifications',
                      style:
                          theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    SpecificationsCard(specs: product.specifications),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: DetailsBottomBar(
        quantity: quantity,
        unitPrice: product.effectivePrice,
        outOfStock: product.isOutOfStock,
        onIncrement: quantity < product.stock
            ? () => setState(() => _quantity = quantity + 1)
            : null,
        onDecrement: quantity > 1 ? () => setState(() => _quantity = quantity - 1) : null,
        onAddToCart: () => _addToCart(product, size, color, quantity),
      ),
    );
  }
}

class _PriceBlock extends StatelessWidget {
  const _PriceBlock({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          formatMoney(product.effectivePrice),
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.primary,
          ),
        ),
        if (product.hasDiscount)
          Text(
            formatMoney(product.price),
            style: theme.textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}

class _StockLabel extends StatelessWidget {
  const _StockLabel({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final (text, color) = product.isOutOfStock
        ? ('Out of stock', AppColors.danger)
        : product.stock <= 5
            ? ('Only ${product.stock} left', Colors.orange.shade700)
            : ('In stock', AppColors.success);

    return Text(
      text,
      style: theme.textTheme.labelLarge?.copyWith(color: color, fontWeight: FontWeight.w700),
    );
  }
}
