import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../profile/presentation/providers/profile_providers.dart';
import '../../../profile/presentation/widgets/add_address_sheet.dart';
import '../providers/checkout_provider.dart';
import 'checkout_section.dart';

Future<void> addAddressAndSelect(BuildContext context, WidgetRef ref) async {
  final address = await showAddAddressSheet(context);
  if (address != null) {
    ref.read(selectedAddressIdProvider.notifier).select(address.id);
  }
}

class AddressSelector extends ConsumerWidget {
  const AddressSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final addresses = ref.watch(addressesProvider);
    final selected = ref.watch(checkoutAddressProvider);

    if (addresses.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You have no saved addresses yet.',
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'Add address',
            icon: Icons.add_location_alt_outlined,
            variant: AppButtonVariant.tonal,
            expand: false,
            onPressed: () => addAddressAndSelect(context, ref),
          ),
        ],
      );
    }

    return Column(
      children: [
        for (final a in addresses)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SelectableTile(
              selected: a.id == selected?.id,
              onTap: () =>
                  ref.read(selectedAddressIdProvider.notifier).select(a.id),
              leading: Icon(
                a.label.toLowerCase() == 'work'
                    ? Icons.work_outline_rounded
                    : Icons.home_outlined,
                color: theme.colorScheme.primary,
              ),
              title: a.isDefault ? '${a.label}  ·  Default' : a.label,
              subtitle: '${a.recipient}\n${a.street}, ${a.city}',
            ),
          ),
      ],
    );
  }
}
