import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_km.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('km')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get navCart;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find something you love'**
  String get homeSubtitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products'**
  String get searchHint;

  /// No description provided for @searchTooltip.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTooltip;

  /// No description provided for @closeSearchTooltip.
  ///
  /// In en, this message translates to:
  /// **'Close search'**
  String get closeSearchTooltip;

  /// No description provided for @cartTooltip.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cartTooltip;

  /// No description provided for @productsTitle.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get productsTitle;

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String itemsCount(int count);

  /// No description provided for @sortTooltip.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortTooltip;

  /// No description provided for @sortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get sortNewest;

  /// No description provided for @sortPriceLowHigh.
  ///
  /// In en, this message translates to:
  /// **'Price: low to high'**
  String get sortPriceLowHigh;

  /// No description provided for @sortPriceHighLow.
  ///
  /// In en, this message translates to:
  /// **'Price: high to low'**
  String get sortPriceHighLow;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @noProductsTitle.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsTitle;

  /// No description provided for @noProductsMessage.
  ///
  /// In en, this message translates to:
  /// **'Try a different keyword or category.'**
  String get noProductsMessage;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Cannot reach the server. Check your internet connection and the API address.'**
  String get errorNetwork;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loadMoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load more products.'**
  String get loadMoreFailed;

  /// No description provided for @outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get outOfStock;

  /// No description provided for @addToCartTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCartTooltip;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'{title} added to cart'**
  String addedToCart(String title);

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @colorLabel.
  ///
  /// In en, this message translates to:
  /// **'Color: {color}'**
  String colorLabel(String color);

  /// No description provided for @specifications.
  ///
  /// In en, this message translates to:
  /// **'Specifications'**
  String get specifications;

  /// No description provided for @addedQtyToCart.
  ///
  /// In en, this message translates to:
  /// **'Added {quantity} × {title}'**
  String addedQtyToCart(int quantity, String title);

  /// No description provided for @viewCart.
  ///
  /// In en, this message translates to:
  /// **'View cart'**
  String get viewCart;

  /// No description provided for @onlyLeft.
  ///
  /// In en, this message translates to:
  /// **'Only {count} left'**
  String onlyLeft(int count);

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get inStock;

  /// No description provided for @addToCartButton.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart  ·  {price}'**
  String addToCartButton(String price);

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get cartTitle;

  /// No description provided for @cartTitleWithCount.
  ///
  /// In en, this message translates to:
  /// **'My Cart ({count})'**
  String cartTitleWithCount(int count);

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @clearCartTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear cart?'**
  String get clearCartTitle;

  /// No description provided for @clearCartMessage.
  ///
  /// In en, this message translates to:
  /// **'All items will be removed from your cart.'**
  String get clearCartMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cartEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmptyTitle;

  /// No description provided for @cartEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Looks like you haven\'t added anything yet.'**
  String get cartEmptyMessage;

  /// No description provided for @startShopping.
  ///
  /// In en, this message translates to:
  /// **'Start shopping'**
  String get startShopping;

  /// No description provided for @sizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Size {size}'**
  String sizeLabel(String size);

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @freeShippingHint.
  ///
  /// In en, this message translates to:
  /// **'Add {amount} more for free shipping'**
  String freeShippingHint(String amount);

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get pushNotifications;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get helpSupport;

  /// No description provided for @orderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get orderHistory;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @shippingAddresses.
  ///
  /// In en, this message translates to:
  /// **'Shipping addresses'**
  String get shippingAddresses;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @noAddresses.
  ///
  /// In en, this message translates to:
  /// **'No saved addresses yet.'**
  String get noAddresses;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @orderProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get orderProcessing;

  /// No description provided for @orderShipped.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get orderShipped;

  /// No description provided for @orderDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orderDelivered;

  /// No description provided for @defaultLabel.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultLabel;

  /// No description provided for @setAsDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get setAsDefault;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @newAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'New shipping address'**
  String get newAddressTitle;

  /// No description provided for @fieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get fieldLabel;

  /// No description provided for @fieldLabelHint.
  ///
  /// In en, this message translates to:
  /// **'Home, Work…'**
  String get fieldLabelHint;

  /// No description provided for @recipientName.
  ///
  /// In en, this message translates to:
  /// **'Recipient name'**
  String get recipientName;

  /// No description provided for @streetAddress.
  ///
  /// In en, this message translates to:
  /// **'Street address'**
  String get streetAddress;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @saveAddress.
  ///
  /// In en, this message translates to:
  /// **'Save address'**
  String get saveAddress;

  /// No description provided for @shippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping address'**
  String get shippingAddress;

  /// No description provided for @addNew.
  ///
  /// In en, this message translates to:
  /// **'Add new'**
  String get addNew;

  /// No description provided for @noSavedAddresses.
  ///
  /// In en, this message translates to:
  /// **'You have no saved addresses yet.'**
  String get noSavedAddresses;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add address'**
  String get addAddress;

  /// No description provided for @deliveryMethod.
  ///
  /// In en, this message translates to:
  /// **'Delivery method'**
  String get deliveryMethod;

  /// No description provided for @deliveryStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard delivery'**
  String get deliveryStandard;

  /// No description provided for @deliveryStandardEta.
  ///
  /// In en, this message translates to:
  /// **'3–5 business days'**
  String get deliveryStandardEta;

  /// No description provided for @deliveryExpress.
  ///
  /// In en, this message translates to:
  /// **'Express delivery'**
  String get deliveryExpress;

  /// No description provided for @deliveryExpressEta.
  ///
  /// In en, this message translates to:
  /// **'1–2 business days'**
  String get deliveryExpressEta;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @payCard.
  ///
  /// In en, this message translates to:
  /// **'Credit / debit card'**
  String get payCard;

  /// No description provided for @payWallet.
  ///
  /// In en, this message translates to:
  /// **'Digital wallet'**
  String get payWallet;

  /// No description provided for @payCash.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get payCash;

  /// No description provided for @walletNote.
  ///
  /// In en, this message translates to:
  /// **'You will confirm the payment in your wallet app after placing the order.'**
  String get walletNote;

  /// No description provided for @cashNote.
  ///
  /// In en, this message translates to:
  /// **'Pay with cash when your order arrives. Please have the exact amount ready.'**
  String get cashNote;

  /// No description provided for @demoPaymentNote.
  ///
  /// In en, this message translates to:
  /// **'Demo checkout: no real payment is processed.'**
  String get demoPaymentNote;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get cardNumber;

  /// No description provided for @cardNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your card number'**
  String get cardNumberRequired;

  /// No description provided for @cardNumberInvalid.
  ///
  /// In en, this message translates to:
  /// **'This card number is not valid'**
  String get cardNumberInvalid;

  /// No description provided for @cardName.
  ///
  /// In en, this message translates to:
  /// **'Name on card'**
  String get cardName;

  /// No description provided for @cardNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter the name on the card'**
  String get cardNameRequired;

  /// No description provided for @expiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry'**
  String get expiry;

  /// No description provided for @expiryFormat.
  ///
  /// In en, this message translates to:
  /// **'Use MM/YY'**
  String get expiryFormat;

  /// No description provided for @invalidMonth.
  ///
  /// In en, this message translates to:
  /// **'Invalid month'**
  String get invalidMonth;

  /// No description provided for @cardExpired.
  ///
  /// In en, this message translates to:
  /// **'Card expired'**
  String get cardExpired;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @cvvInvalid.
  ///
  /// In en, this message translates to:
  /// **'3 or 4 digits'**
  String get cvvInvalid;

  /// No description provided for @testCardHint.
  ///
  /// In en, this message translates to:
  /// **'Test card: 4242 4242 4242 4242, any future date, any CVV'**
  String get testCardHint;

  /// No description provided for @promoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo code'**
  String get promoCode;

  /// No description provided for @promoHint.
  ///
  /// In en, this message translates to:
  /// **'Enter code (try SAVE10)'**
  String get promoHint;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @promoInvalid.
  ///
  /// In en, this message translates to:
  /// **'This promo code is not valid'**
  String get promoInvalid;

  /// No description provided for @promoApplied.
  ///
  /// In en, this message translates to:
  /// **'{code} applied  ·  10% off'**
  String promoApplied(String code);

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order summary'**
  String get orderSummary;

  /// No description provided for @qty.
  ///
  /// In en, this message translates to:
  /// **'Qty {count}'**
  String qty(int count);

  /// No description provided for @promoDiscount.
  ///
  /// In en, this message translates to:
  /// **'Promo discount'**
  String get promoDiscount;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place order'**
  String get placeOrder;

  /// No description provided for @addAddressToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please add a shipping address to continue.'**
  String get addAddressToContinue;

  /// No description provided for @checkCardDetails.
  ///
  /// In en, this message translates to:
  /// **'Please check your card details.'**
  String get checkCardDetails;

  /// No description provided for @backToCart.
  ///
  /// In en, this message translates to:
  /// **'Back to cart'**
  String get backToCart;

  /// No description provided for @orderPlaced.
  ///
  /// In en, this message translates to:
  /// **'Order placed!'**
  String get orderPlaced;

  /// No description provided for @orderPlacedMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your purchase. We will send you updates as your order is prepared.'**
  String get orderPlacedMessage;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order number'**
  String get orderNumber;

  /// No description provided for @totalPaid.
  ///
  /// In en, this message translates to:
  /// **'Total paid'**
  String get totalPaid;

  /// No description provided for @shipTo.
  ///
  /// In en, this message translates to:
  /// **'Ship to'**
  String get shipTo;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @viewMyOrders.
  ///
  /// In en, this message translates to:
  /// **'View my orders'**
  String get viewMyOrders;

  /// No description provided for @continueShopping.
  ///
  /// In en, this message translates to:
  /// **'Continue shopping'**
  String get continueShopping;

  /// No description provided for @bannerAutumnTitle.
  ///
  /// In en, this message translates to:
  /// **'Autumn Sale'**
  String get bannerAutumnTitle;

  /// No description provided for @bannerAutumnSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Up to 40% off on selected styles'**
  String get bannerAutumnSubtitle;

  /// No description provided for @bannerNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New Arrivals'**
  String get bannerNewTitle;

  /// No description provided for @bannerNewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fresh picks to upgrade your wardrobe'**
  String get bannerNewSubtitle;

  /// No description provided for @bannerShipTitle.
  ///
  /// In en, this message translates to:
  /// **'Free Shipping'**
  String get bannerShipTitle;

  /// No description provided for @bannerShipSubtitle.
  ///
  /// In en, this message translates to:
  /// **'On all orders over \$100'**
  String get bannerShipSubtitle;

  /// No description provided for @shopNow.
  ///
  /// In en, this message translates to:
  /// **'Shop now'**
  String get shopNow;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get learnMore;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'km'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'km':
      return AppLocalizationsKm();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
