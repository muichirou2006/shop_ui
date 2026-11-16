import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provided in main() with the real instance.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(
      'sharedPreferencesProvider must be overridden in main()'),
);

/// The language of the app. Saved on the phone, so it is remembered after a restart.
class LocaleNotifier extends Notifier<Locale> {
  static const _key = 'language_code';

  @override
  Locale build() {
    final code = ref.watch(sharedPreferencesProvider).getString(_key);
    return Locale(code == 'km' ? 'km' : 'en');
  }

  Future<void> set(Locale locale) async {
    state = locale;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_key, locale.languageCode);
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);
