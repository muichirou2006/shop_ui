import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/locale/locale_provider.dart';
import '../../../../l10n/l10n.dart';

/// Language names are always shown in their own language.
const _languages = <({String name, Locale locale})>[
  (name: 'English', locale: Locale('en')),
  (name: 'ខ្មែរ', locale: Locale('km')),
];

Future<void> showLanguageSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (_) => const _LanguageSheet(),
  );
}

class _LanguageSheet extends ConsumerWidget {
  const _LanguageSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final current = ref.watch(localeProvider);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Text(
              context.l10n.chooseLanguage,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          for (final language in _languages)
            ListTile(
              title: Text(language.name),
              trailing: current.languageCode == language.locale.languageCode
                  ? Icon(Icons.check_circle_rounded,
                      color: theme.colorScheme.primary)
                  : null,
              onTap: () {
                ref.read(localeProvider.notifier).set(language.locale);
                Navigator.of(context).pop();
              },
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
