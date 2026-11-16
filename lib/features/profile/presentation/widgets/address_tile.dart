import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/address.dart';
import '../providers/profile_providers.dart';
import '../../../../l10n/l10n.dart';

class AddressTile extends ConsumerWidget {
  const AddressTile({super.key, required this.address});

  final Address address;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final notifier = ref.read(addressesProvider.notifier);

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            address.label.toLowerCase() == 'work'
                ? Icons.work_outline_rounded
                : Icons.home_outlined,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        title: Row(
          children: [
            Flexible(
                child: Text(context.l10n.defaultLabel,
                    style: theme.textTheme.labelSmall)),
            if (address.isDefault) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text('Default', style: theme.textTheme.labelSmall),
              ),
            ],
          ],
        ),
        subtitle:
            Text('${address.recipient}\n${address.street}, ${address.city}'),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'default') notifier.makeDefault(address.id);
            if (value == 'delete') notifier.remove(address.id);
          },
          itemBuilder: (_) => [
            if (!address.isDefault)
              PopupMenuItem(
                  value: 'default', child: Text(context.l10n.setAsDefault)),
            PopupMenuItem(value: 'delete', child: Text(context.l10n.delete)),
          ],
        ),
      ),
    );
  }
}
