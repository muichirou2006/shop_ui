// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shop';

  @override
  String get navHome => 'Home';

  @override
  String get navCart => 'Cart';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeTitle => 'Discover';

  @override
  String get homeSubtitle => 'Find something you love';

  @override
  String get searchHint => 'Search products';

  @override
  String get searchTooltip => 'Search';

  @override
  String get closeSearchTooltip => 'Close search';

  @override
  String get cartTooltip => 'Cart';

  @override
  String get productsTitle => 'Products';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get sortTooltip => 'Sort';

  @override
  String get sortNewest => 'Newest';

  @override
  String get sortPriceLowHigh => 'Price: low to high';

  @override
  String get sortPriceHighLow => 'Price: high to low';

  @override
  String get categoryAll => 'All';

  @override
  String get noProductsTitle => 'No products found';

  @override
  String get noProductsMessage => 'Try a different keyword or category.';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorNetwork =>
      'Cannot reach the server. Check your internet connection and the API address.';

  @override
  String get tryAgain => 'Try again';

  @override
  String get retry => 'Retry';

  @override
  String get loadMoreFailed => 'Could not load more products.';

  @override
  String get outOfStock => 'Out of stock';

  @override
  String get addToCartTooltip => 'Add to cart';

  @override
  String addedToCart(String title) {
    return '$title added to cart';
  }

  @override
  String get description => 'Description';

  @override
  String get size => 'Size';

  @override
  String colorLabel(String color) {
    return 'Color: $color';
  }

  @override
  String get specifications => 'Specifications';

  @override
  String addedQtyToCart(int quantity, String title) {
    return 'Added $quantity × $title';
  }

  @override
  String get viewCart => 'View cart';

  @override
  String onlyLeft(int count) {
    return 'Only $count left';
  }

  @override
  String get inStock => 'In stock';

  @override
  String addToCartButton(String price) {
    return 'Add to Cart  ·  $price';
  }

  @override
  String get cartTitle => 'My Cart';

  @override
  String cartTitleWithCount(int count) {
    return 'My Cart ($count)';
  }

  @override
  String get clear => 'Clear';

  @override
  String get clearCartTitle => 'Clear cart?';

  @override
  String get clearCartMessage => 'All items will be removed from your cart.';

  @override
  String get cancel => 'Cancel';

  @override
  String get cartEmptyTitle => 'Your cart is empty';

  @override
  String get cartEmptyMessage => 'Looks like you haven\'t added anything yet.';

  @override
  String get startShopping => 'Start shopping';

  @override
  String sizeLabel(String size) {
    return 'Size $size';
  }

  @override
  String get subtotal => 'Subtotal';

  @override
  String get shipping => 'Shipping';

  @override
  String get free => 'Free';

  @override
  String freeShippingHint(String amount) {
    return 'Add $amount more for free shipping';
  }

  @override
  String get total => 'Total';

  @override
  String get checkout => 'Checkout';

  @override
  String get accountTitle => 'Account';

  @override
  String get settings => 'Settings';

  @override
  String get pushNotifications => 'Push notifications';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get helpSupport => 'Help & support';

  @override
  String get orderHistory => 'Order history';

  @override
  String get seeAll => 'See all';

  @override
  String get shippingAddresses => 'Shipping addresses';

  @override
  String get add => 'Add';

  @override
  String get noAddresses => 'No saved addresses yet.';

  @override
  String get signOut => 'Sign out';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get orderProcessing => 'Processing';

  @override
  String get orderShipped => 'Shipped';

  @override
  String get orderDelivered => 'Delivered';

  @override
  String get defaultLabel => 'Default';

  @override
  String get setAsDefault => 'Set as default';

  @override
  String get delete => 'Delete';

  @override
  String get newAddressTitle => 'New shipping address';

  @override
  String get fieldLabel => 'Label';

  @override
  String get fieldLabelHint => 'Home, Work…';

  @override
  String get recipientName => 'Recipient name';

  @override
  String get streetAddress => 'Street address';

  @override
  String get city => 'City';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get saveAddress => 'Save address';

  @override
  String get shippingAddress => 'Shipping address';

  @override
  String get addNew => 'Add new';

  @override
  String get noSavedAddresses => 'You have no saved addresses yet.';

  @override
  String get addAddress => 'Add address';

  @override
  String get deliveryMethod => 'Delivery method';

  @override
  String get deliveryStandard => 'Standard delivery';

  @override
  String get deliveryStandardEta => '3–5 business days';

  @override
  String get deliveryExpress => 'Express delivery';

  @override
  String get deliveryExpressEta => '1–2 business days';

  @override
  String get paymentMethod => 'Payment method';

  @override
  String get payCard => 'Credit / debit card';

  @override
  String get payWallet => 'Digital wallet';

  @override
  String get payCash => 'Cash on delivery';

  @override
  String get walletNote =>
      'You will confirm the payment in your wallet app after placing the order.';

  @override
  String get cashNote =>
      'Pay with cash when your order arrives. Please have the exact amount ready.';

  @override
  String get demoPaymentNote => 'Demo checkout: no real payment is processed.';

  @override
  String get cardNumber => 'Card number';

  @override
  String get cardNumberRequired => 'Enter your card number';

  @override
  String get cardNumberInvalid => 'This card number is not valid';

  @override
  String get cardName => 'Name on card';

  @override
  String get cardNameRequired => 'Enter the name on the card';

  @override
  String get expiry => 'Expiry';

  @override
  String get expiryFormat => 'Use MM/YY';

  @override
  String get invalidMonth => 'Invalid month';

  @override
  String get cardExpired => 'Card expired';

  @override
  String get cvv => 'CVV';

  @override
  String get cvvInvalid => '3 or 4 digits';

  @override
  String get testCardHint =>
      'Test card: 4242 4242 4242 4242, any future date, any CVV';

  @override
  String get promoCode => 'Promo code';

  @override
  String get promoHint => 'Enter code (try SAVE10)';

  @override
  String get apply => 'Apply';

  @override
  String get promoInvalid => 'This promo code is not valid';

  @override
  String promoApplied(String code) {
    return '$code applied  ·  10% off';
  }

  @override
  String get remove => 'Remove';

  @override
  String get orderSummary => 'Order summary';

  @override
  String qty(int count) {
    return 'Qty $count';
  }

  @override
  String get promoDiscount => 'Promo discount';

  @override
  String get delivery => 'Delivery';

  @override
  String get placeOrder => 'Place order';

  @override
  String get addAddressToContinue =>
      'Please add a shipping address to continue.';

  @override
  String get checkCardDetails => 'Please check your card details.';

  @override
  String get backToCart => 'Back to cart';

  @override
  String get orderPlaced => 'Order placed!';

  @override
  String get orderPlacedMessage =>
      'Thank you for your purchase. We will send you updates as your order is prepared.';

  @override
  String get orderNumber => 'Order number';

  @override
  String get totalPaid => 'Total paid';

  @override
  String get shipTo => 'Ship to';

  @override
  String get payment => 'Payment';

  @override
  String get viewMyOrders => 'View my orders';

  @override
  String get continueShopping => 'Continue shopping';

  @override
  String get bannerAutumnTitle => 'Autumn Sale';

  @override
  String get bannerAutumnSubtitle => 'Up to 40% off on selected styles';

  @override
  String get bannerNewTitle => 'New Arrivals';

  @override
  String get bannerNewSubtitle => 'Fresh picks to upgrade your wardrobe';

  @override
  String get bannerShipTitle => 'Free Shipping';

  @override
  String get bannerShipSubtitle => 'On all orders over \$100';

  @override
  String get shopNow => 'Shop now';

  @override
  String get explore => 'Explore';

  @override
  String get learnMore => 'Learn more';
}
