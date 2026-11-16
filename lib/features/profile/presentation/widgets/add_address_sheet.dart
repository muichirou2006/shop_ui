import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/address.dart';
import '../providers/profile_providers.dart';

/// Resolves to the new address when saved, or null if the sheet was dismissed.
Future<Address?> showAddAddressSheet(BuildContext context) {
  return showModalBottomSheet<Address>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const _AddAddressSheet(),
  );
}

class _AddAddressSheet extends ConsumerStatefulWidget {
  const _AddAddressSheet();

  @override
  ConsumerState<_AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends ConsumerState<_AddAddressSheet> {
  final _formKey = GlobalKey<FormState>();
  final _label = TextEditingController();
  final _recipient = TextEditingController();
  final _street = TextEditingController();
  final _city = TextEditingController();

  @override
  void dispose() {
    _label.dispose();
    _recipient.dispose();
    _street.dispose();
    _city.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'This field is required' : null;

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final address = ref.read(addressesProvider.notifier).add(
          label: _label.text.trim(),
          recipient: _recipient.text.trim(),
          street: _street.text.trim(),
          city: _city.text.trim(),
        );
    Navigator.of(context).pop(address);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        4,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New shipping address',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _label,
                label: 'Label',
                hint: 'Home, Work…',
                prefixIcon: Icons.label_outline_rounded,
                validator: _required,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _recipient,
                label: 'Recipient name',
                prefixIcon: Icons.person_outline_rounded,
                validator: _required,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _street,
                label: 'Street address',
                prefixIcon: Icons.location_on_outlined,
                validator: _required,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _city,
                label: 'City',
                prefixIcon: Icons.location_city_rounded,
                validator: _required,
              ),
              const SizedBox(height: 20),
              AppButton(label: 'Save address', onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
