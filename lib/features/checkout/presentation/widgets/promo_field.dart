import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../providers/checkout_provider.dart';

class PromoField extends ConsumerStatefulWidget {
  const PromoField({super.key});

  @override
  ConsumerState<PromoField> createState() => _PromoFieldState();
}

class _PromoFieldState extends ConsumerState<PromoField> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _apply() {
    final ok = ref.read(promoProvider.notifier).apply(_controller.text);
    setState(() => _error = ok ? null : 'This promo code is not valid');
    if (ok) _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final applied = ref.watch(promoProvider);

    if (applied != null) {
      return Container(
        padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.local_offer_rounded,
                size: 20, color: AppColors.success),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$applied applied  ·  10% off',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              onPressed: ref.read(promoProvider.notifier).clear,
              child: const Text('Remove'),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.characters,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _apply(),
                decoration: const InputDecoration(
                  hintText: 'Enter code (try SAVE10)',
                  prefixIcon: Icon(Icons.discount_outlined),
                ),
              ),
            ),
            const SizedBox(width: 10),
            AppButton(
              label: 'Apply',
              expand: false,
              variant: AppButtonVariant.tonal,
              onPressed: _apply,
            ),
          ],
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              _error!,
              style:
                  theme.textTheme.bodySmall?.copyWith(color: AppColors.danger),
            ),
          ),
      ],
    );
  }
}
