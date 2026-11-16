import 'package:flutter/widgets.dart';

import '../features/product/domain/product_sort.dart';
import 'app_localizations.dart';

export 'app_localizations.dart';

/// Short access to translations: `context.l10n.navHome`
extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension ProductSortL10n on ProductSort {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
        ProductSort.newest => l10n.sortNewest,
        ProductSort.priceAsc => l10n.sortPriceLowHigh,
        ProductSort.priceDesc => l10n.sortPriceHighLow,
      };
}
