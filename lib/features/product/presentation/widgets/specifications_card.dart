import 'package:flutter/material.dart';

/// Shows the dynamic, category-specific attributes coming from the API
/// (storage, wattage, weight, material, ...).
class SpecificationsCard extends StatelessWidget {
  const SpecificationsCard({super.key, required this.specs});

  final Map<String, dynamic> specs;

  static String _label(String key) {
    final text = key.replaceAll('_', ' ').trim();
    if (text.isEmpty) return key;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String _value(dynamic value) {
    if (value is List) return value.join(', ');
    if (value is bool) return value ? 'Yes' : 'No';
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (specs.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final entries = specs.entries.toList();

    return Card(
      child: Column(
        children: [
          for (var i = 0; i < entries.length; i++) ...[
            if (i > 0) const Divider(height: 1, indent: 16, endIndent: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      _label(entries[i].key),
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      _value(entries[i].value),
                      textAlign: TextAlign.end,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
