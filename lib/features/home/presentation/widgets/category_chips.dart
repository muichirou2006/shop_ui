import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/domain/category.dart';
import '../../../product/presentation/providers/product_providers.dart';
import '../providers/home_providers.dart';
import '../../../../l10n/l10n.dart';

class CategoryChips extends ConsumerWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(categoriesProvider);
    final selected = ref.watch(selectedCategoryProvider);
    final categories = async.valueOrNull ?? const <Category>[];

    if (async.isLoading && categories.isEmpty) return const _ChipsPlaceholder();

    final notifier = ref.read(selectedCategoryProvider.notifier);

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          if (i == 0) {
            return ChoiceChip(
              avatar: const Icon(Icons.apps_rounded, size: 18),
              label: Text(context.l10n.categoryAll),
              selected: selected == null,
              onSelected: (_) => notifier.select(null),
            );
          }
          final c = categories[i - 1];
          return ChoiceChip(
            avatar: Icon(c.icon, size: 18),
            label: Text(c.name),
            selected: selected == c.slug,
            onSelected: (_) => notifier.select(c.slug),
          );
        },
      ),
    );
  }
}

class _ChipsPlaceholder extends StatelessWidget {
  const _ChipsPlaceholder();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, __) => Container(
          width: 88,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }
}
