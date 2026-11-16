import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/order.dart';
import '../../../../l10n/l10n.dart';

class OrderHistoryList extends StatelessWidget {
  const OrderHistoryList({super.key, required this.orders});

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          for (var i = 0; i < orders.length; i++) ...[
            if (i > 0) const Divider(height: 1, indent: 16, endIndent: 16),
            _OrderTile(order: orders[i]),
          ],
        ],
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({required this.order});

  final Order order;

  (String, Color) _status(AppLocalizations l10n) => switch (order.status) {
        OrderStatus.processing => (l10n.orderProcessing, Colors.orange),
        OrderStatus.shipped => (l10n.orderShipped, Colors.blue),
        OrderStatus.delivered => (l10n.orderDelivered, AppColors.success),
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final (label, color) = _status(l10n);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Icon(Icons.inventory_2_outlined,
            color: theme.colorScheme.onPrimaryContainer),
      ),
      title: Text(
        '#${order.id}',
        style:
            theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        '${DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(order.date)}'
        '  ·  ${l10n.itemsCount(order.itemCount)}',
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatMoney(order.total),
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.labelSmall
                ?.copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
