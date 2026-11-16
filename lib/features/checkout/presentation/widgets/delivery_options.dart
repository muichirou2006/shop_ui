import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/formatters.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../domain/checkout_options.dart';
import '../providers/checkout_provider.dart';
import 'checkout_section.dart';

class DeliveryOptions extends ConsumerWidget {
  const DeliveryOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selected = ref.watch(deliveryMethodProvider);
    final subtotal = ref.watch(cartSubtotalProvider);

    return Column(
      children: [
        for (final method in DeliveryMethod.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SelectableTile(
              selected: method == selected,
              onTap: () =>
                  ref.read(deliveryMethodProvider.notifier).select(method),
              leading: Icon(method.icon, color: theme.colorScheme.primary),
              title: method.title,
              subtitle: method.eta,
              trailing: Text(
                deliveryFee(method, subtotal) == 0
                    ? 'Free'
                    : formatMoney(deliveryFee(method, subtotal)),
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),
      ],
    );
  }
}
