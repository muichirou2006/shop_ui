import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/input_formatters.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/checkout_options.dart';
import '../providers/checkout_provider.dart';
import 'checkout_section.dart';

class PaymentSection extends ConsumerWidget {
  const PaymentSection({super.key, required this.cardFormKey});

  /// Used by the checkout screen to validate the card fields before ordering.
  final GlobalKey<FormState> cardFormKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selected = ref.watch(paymentMethodProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final method in PaymentMethod.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SelectableTile(
              selected: method == selected,
              onTap: () =>
                  ref.read(paymentMethodProvider.notifier).select(method),
              leading: Icon(method.icon, color: theme.colorScheme.primary),
              title: method.title,
            ),
          ),
        const SizedBox(height: 4),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: switch (selected) {
            PaymentMethod.card => _CardForm(formKey: cardFormKey),
            PaymentMethod.wallet => const _InfoNote(
                icon: Icons.phone_iphone_rounded,
                text:
                    'You will confirm the payment in your wallet app after placing the order.',
              ),
            PaymentMethod.cash => const _InfoNote(
                icon: Icons.payments_outlined,
                text:
                    'Pay with cash when your order arrives. Please have the exact amount ready.',
              ),
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.info_outline_rounded,
                size: 16, color: theme.colorScheme.outline),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Demo checkout: no real payment is processed.',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.outline),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoNote extends StatelessWidget {
  const _InfoNote({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: theme.textTheme.bodySmall)),
        ],
      ),
    );
  }
}

class _CardForm extends StatefulWidget {
  const _CardForm({required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<_CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<_CardForm> {
  final _number = TextEditingController();
  final _name = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();

  @override
  void dispose() {
    _number.dispose();
    _name.dispose();
    _expiry.dispose();
    _cvv.dispose();
    super.dispose();
  }

  static bool _luhnValid(String digits) {
    var sum = 0;
    var alternate = false;
    for (var i = digits.length - 1; i >= 0; i--) {
      var n = int.parse(digits[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }

  static String? _validateNumber(String? value) {
    final digits = (value ?? '').replaceAll(' ', '');
    if (digits.length < 13) return 'Enter your card number';
    if (!_luhnValid(digits)) return 'This card number is not valid';
    return null;
  }

  static String? _validateName(String? value) {
    if (value == null || value.trim().length < 2) {
      return 'Enter the name on the card';
    }
    return null;
  }

  static String? _validateExpiry(String? value) {
    final match = RegExp(r'^(\d{2})/(\d{2})$').firstMatch((value ?? '').trim());
    if (match == null) return 'Use MM/YY';
    final month = int.parse(match.group(1)!);
    final year = 2000 + int.parse(match.group(2)!);
    if (month < 1 || month > 12) return 'Invalid month';
    final now = DateTime.now();
    if (year < now.year || (year == now.year && month < now.month)) {
      return 'Card expired';
    }
    return null;
  }

  static String? _validateCvv(String? value) {
    final v = (value ?? '').trim();
    if (v.length < 3 || v.length > 4) return '3 or 4 digits';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextField(
            controller: _number,
            label: 'Card number',
            hint: '4242 4242 4242 4242',
            prefixIcon: Icons.credit_card_rounded,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [CardNumberFormatter()],
            validator: _validateNumber,
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: _name,
            label: 'Name on card',
            prefixIcon: Icons.person_outline_rounded,
            textInputAction: TextInputAction.next,
            validator: _validateName,
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  controller: _expiry,
                  label: 'Expiry',
                  hint: 'MM/YY',
                  prefixIcon: Icons.event_outlined,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [ExpiryDateFormatter()],
                  validator: _validateExpiry,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppTextField(
                  controller: _cvv,
                  label: 'CVV',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscure: true,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  validator: _validateCvv,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Test card: 4242 4242 4242 4242, any future date, any CVV',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.success),
            ),
          ),
        ],
      ),
    );
  }
}
