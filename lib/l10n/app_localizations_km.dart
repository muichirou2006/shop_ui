// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get appTitle => 'ហាង';

  @override
  String get navHome => 'ទំព័រដើម';

  @override
  String get navCart => 'កន្ត្រក';

  @override
  String get navProfile => 'ប្រវត្តិរូប';

  @override
  String get homeTitle => 'ស្វែងយល់';

  @override
  String get homeSubtitle => 'រកឃើញអ្វីដែលអ្នកចូលចិត្ត';

  @override
  String get searchHint => 'ស្វែងរកផលិតផល';

  @override
  String get searchTooltip => 'ស្វែងរក';

  @override
  String get closeSearchTooltip => 'បិទការស្វែងរក';

  @override
  String get cartTooltip => 'កន្ត្រក';

  @override
  String get productsTitle => 'ផលិតផល';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ទំនិញ',
    );
    return '$_temp0';
  }

  @override
  String get sortTooltip => 'តម្រៀប';

  @override
  String get sortNewest => 'ថ្មីបំផុត';

  @override
  String get sortPriceLowHigh => 'តម្លៃ៖ ពីទាបទៅខ្ពស់';

  @override
  String get sortPriceHighLow => 'តម្លៃ៖ ពីខ្ពស់ទៅទាប';

  @override
  String get categoryAll => 'ទាំងអស់';

  @override
  String get noProductsTitle => 'រកមិនឃើញផលិតផលទេ';

  @override
  String get noProductsMessage => 'សូមសាកល្បងពាក្យគន្លឹះ ឬប្រភេទផ្សេង។';

  @override
  String get errorTitle => 'មានបញ្ហាអ្វីមួយ';

  @override
  String get errorGeneric => 'មានបញ្ហាអ្វីមួយ។ សូមព្យាយាមម្តងទៀត។';

  @override
  String get errorNetwork =>
      'មិនអាចភ្ជាប់ទៅម៉ាស៊ីនមេបានទេ។ សូមពិនិត្យអ៊ីនធឺណិត និងអាសយដ្ឋាន API របស់អ្នក។';

  @override
  String get tryAgain => 'ព្យាយាមម្តងទៀត';

  @override
  String get retry => 'ព្យាយាមម្តងទៀត';

  @override
  String get loadMoreFailed => 'មិនអាចផ្ទុកផលិតផលបន្ថែមបានទេ។';

  @override
  String get outOfStock => 'អស់ស្តុក';

  @override
  String get addToCartTooltip => 'ដាក់ក្នុងកន្ត្រក';

  @override
  String addedToCart(String title) {
    return 'បានដាក់ $title ក្នុងកន្ត្រក';
  }

  @override
  String get description => 'ការពិពណ៌នា';

  @override
  String get size => 'ទំហំ';

  @override
  String colorLabel(String color) {
    return 'ពណ៌៖ $color';
  }

  @override
  String get specifications => 'លក្ខណៈបច្ចេកទេស';

  @override
  String addedQtyToCart(int quantity, String title) {
    return 'បានបន្ថែម $quantity × $title';
  }

  @override
  String get viewCart => 'មើលកន្ត្រក';

  @override
  String onlyLeft(int count) {
    return 'នៅសល់ត្រឹម $count';
  }

  @override
  String get inStock => 'មានក្នុងស្តុក';

  @override
  String addToCartButton(String price) {
    return 'ដាក់ក្នុងកន្ត្រក  ·  $price';
  }

  @override
  String get cartTitle => 'កន្ត្រករបស់ខ្ញុំ';

  @override
  String cartTitleWithCount(int count) {
    return 'កន្ត្រករបស់ខ្ញុំ ($count)';
  }

  @override
  String get clear => 'សម្អាត';

  @override
  String get clearCartTitle => 'សម្អាតកន្ត្រក?';

  @override
  String get clearCartMessage => 'ទំនិញទាំងអស់នឹងត្រូវដកចេញពីកន្ត្រករបស់អ្នក។';

  @override
  String get cancel => 'បោះបង់';

  @override
  String get cartEmptyTitle => 'កន្ត្រករបស់អ្នកទទេ';

  @override
  String get cartEmptyMessage => 'ហាក់ដូចជាអ្នកមិនទាន់បានបន្ថែមអ្វីនៅឡើយទេ។';

  @override
  String get startShopping => 'ចាប់ផ្តើមទិញទំនិញ';

  @override
  String sizeLabel(String size) {
    return 'ទំហំ $size';
  }

  @override
  String get subtotal => 'សរុបរង';

  @override
  String get shipping => 'ការដឹកជញ្ជូន';

  @override
  String get free => 'ឥតគិតថ្លៃ';

  @override
  String freeShippingHint(String amount) {
    return 'បន្ថែម $amount ទៀត ដើម្បីទទួលបានការដឹកជញ្ជូនឥតគិតថ្លៃ';
  }

  @override
  String get total => 'សរុប';

  @override
  String get checkout => 'ទូទាត់ប្រាក់';

  @override
  String get accountTitle => 'គណនី';

  @override
  String get settings => 'ការកំណត់';

  @override
  String get pushNotifications => 'ការជូនដំណឹង';

  @override
  String get darkMode => 'ម៉ូដងងឹត';

  @override
  String get language => 'ភាសា';

  @override
  String get chooseLanguage => 'ជ្រើសរើសភាសា';

  @override
  String get helpSupport => 'ជំនួយ និងការគាំទ្រ';

  @override
  String get orderHistory => 'ប្រវត្តិការបញ្ជាទិញ';

  @override
  String get seeAll => 'មើលទាំងអស់';

  @override
  String get shippingAddresses => 'អាសយដ្ឋានដឹកជញ្ជូន';

  @override
  String get add => 'បន្ថែម';

  @override
  String get noAddresses => 'មិនទាន់មានអាសយដ្ឋានដែលបានរក្សាទុកនៅឡើយទេ។';

  @override
  String get signOut => 'ចាកចេញ';

  @override
  String get editProfile => 'កែប្រែប្រវត្តិរូប';

  @override
  String get orderProcessing => 'កំពុងដំណើរការ';

  @override
  String get orderShipped => 'កំពុងដឹកជញ្ជូន';

  @override
  String get orderDelivered => 'បានដឹកដល់';

  @override
  String get defaultLabel => 'លំនាំដើម';

  @override
  String get setAsDefault => 'កំណត់ជាលំនាំដើម';

  @override
  String get delete => 'លុប';

  @override
  String get newAddressTitle => 'អាសយដ្ឋានដឹកជញ្ជូនថ្មី';

  @override
  String get fieldLabel => 'ស្លាក';

  @override
  String get fieldLabelHint => 'ផ្ទះ ការិយាល័យ…';

  @override
  String get recipientName => 'ឈ្មោះអ្នកទទួល';

  @override
  String get streetAddress => 'អាសយដ្ឋានផ្លូវ';

  @override
  String get city => 'ទីក្រុង';

  @override
  String get fieldRequired => 'ត្រូវបំពេញចន្លោះនេះ';

  @override
  String get saveAddress => 'រក្សាទុកអាសយដ្ឋាន';

  @override
  String get shippingAddress => 'អាសយដ្ឋានដឹកជញ្ជូន';

  @override
  String get addNew => 'បន្ថែមថ្មី';

  @override
  String get noSavedAddresses => 'អ្នកមិនទាន់មានអាសយដ្ឋានដែលបានរក្សាទុកទេ។';

  @override
  String get addAddress => 'បន្ថែមអាសយដ្ឋាន';

  @override
  String get deliveryMethod => 'វិធីដឹកជញ្ជូន';

  @override
  String get deliveryStandard => 'ការដឹកជញ្ជូនធម្មតា';

  @override
  String get deliveryStandardEta => '3–5 ថ្ងៃធ្វើការ';

  @override
  String get deliveryExpress => 'ការដឹកជញ្ជូនរហ័ស';

  @override
  String get deliveryExpressEta => '1–2 ថ្ងៃធ្វើការ';

  @override
  String get paymentMethod => 'វិធីបង់ប្រាក់';

  @override
  String get payCard => 'កាតឥណទាន / ឥណពន្ធ';

  @override
  String get payWallet => 'កាបូបអេឡិចត្រូនិក';

  @override
  String get payCash => 'បង់ប្រាក់ពេលទទួលទំនិញ';

  @override
  String get walletNote =>
      'អ្នកនឹងបញ្ជាក់ការបង់ប្រាក់ក្នុងកម្មវិធីកាបូបរបស់អ្នក បន្ទាប់ពីបញ្ជាទិញ។';

  @override
  String get cashNote =>
      'បង់ប្រាក់ជាសាច់ប្រាក់នៅពេលទំនិញមកដល់។ សូមរៀបចំចំនួនទឹកប្រាក់ឱ្យត្រឹមត្រូវ។';

  @override
  String get demoPaymentNote =>
      'ការទូទាត់សាកល្បង៖ មិនមានការបង់ប្រាក់ពិតប្រាកដទេ។';

  @override
  String get cardNumber => 'លេខកាត';

  @override
  String get cardNumberRequired => 'បញ្ចូលលេខកាតរបស់អ្នក';

  @override
  String get cardNumberInvalid => 'លេខកាតនេះមិនត្រឹមត្រូវទេ';

  @override
  String get cardName => 'ឈ្មោះលើកាត';

  @override
  String get cardNameRequired => 'បញ្ចូលឈ្មោះលើកាត';

  @override
  String get expiry => 'ថ្ងៃផុតកំណត់';

  @override
  String get expiryFormat => 'ប្រើទម្រង់ ខែ/ឆ្នាំ (MM/YY)';

  @override
  String get invalidMonth => 'ខែមិនត្រឹមត្រូវ';

  @override
  String get cardExpired => 'កាតបានផុតកំណត់';

  @override
  String get cvv => 'CVV';

  @override
  String get cvvInvalid => '3 ឬ 4 ខ្ទង់';

  @override
  String get testCardHint =>
      'កាតសាកល្បង៖ 4242 4242 4242 4242 ថ្ងៃផុតកំណត់នៅអនាគតណាមួយ និង CVV ណាមួយ';

  @override
  String get promoCode => 'កូដបញ្ចុះតម្លៃ';

  @override
  String get promoHint => 'បញ្ចូលកូដ (សាកល្បង SAVE10)';

  @override
  String get apply => 'អនុវត្ត';

  @override
  String get promoInvalid => 'កូដបញ្ចុះតម្លៃនេះមិនត្រឹមត្រូវទេ';

  @override
  String promoApplied(String code) {
    return 'បានអនុវត្ត $code  ·  បញ្ចុះតម្លៃ 10%';
  }

  @override
  String get remove => 'ដកចេញ';

  @override
  String get orderSummary => 'សង្ខេបការបញ្ជាទិញ';

  @override
  String qty(int count) {
    return 'ចំនួន $count';
  }

  @override
  String get promoDiscount => 'ការបញ្ចុះតម្លៃ';

  @override
  String get delivery => 'ការដឹកជញ្ជូន';

  @override
  String get placeOrder => 'បញ្ជាទិញ';

  @override
  String get addAddressToContinue => 'សូមបន្ថែមអាសយដ្ឋានដឹកជញ្ជូន ដើម្បីបន្ត។';

  @override
  String get checkCardDetails => 'សូមពិនិត្យព័ត៌មានកាតរបស់អ្នក។';

  @override
  String get backToCart => 'ត្រឡប់ទៅកន្ត្រក';

  @override
  String get orderPlaced => 'បានបញ្ជាទិញដោយជោគជ័យ!';

  @override
  String get orderPlacedMessage =>
      'សូមអរគុណសម្រាប់ការទិញរបស់អ្នក។ យើងនឹងជូនដំណឹងអ្នកអំពីដំណើរការនៃការបញ្ជាទិញ។';

  @override
  String get orderNumber => 'លេខបញ្ជាទិញ';

  @override
  String get totalPaid => 'ចំនួនទឹកប្រាក់ដែលបានបង់';

  @override
  String get shipTo => 'ដឹកជញ្ជូនទៅ';

  @override
  String get payment => 'ការបង់ប្រាក់';

  @override
  String get viewMyOrders => 'មើលការបញ្ជាទិញរបស់ខ្ញុំ';

  @override
  String get continueShopping => 'បន្តទិញទំនិញ';

  @override
  String get bannerAutumnTitle => 'បញ្ចុះតម្លៃរដូវស្លឹកឈើជ្រុះ';

  @override
  String get bannerAutumnSubtitle =>
      'បញ្ចុះតម្លៃរហូតដល់ 40% លើម៉ូដដែលបានជ្រើសរើស';

  @override
  String get bannerNewTitle => 'ទំនិញមកដល់ថ្មី';

  @override
  String get bannerNewSubtitle =>
      'ជម្រើសថ្មីៗ ដើម្បីបំប្លែងសម្លៀកបំពាក់របស់អ្នក';

  @override
  String get bannerShipTitle => 'ដឹកជញ្ជូនឥតគិតថ្លៃ';

  @override
  String get bannerShipSubtitle => 'សម្រាប់ការបញ្ជាទិញលើសពី \$100';

  @override
  String get shopNow => 'ទិញឥឡូវនេះ';

  @override
  String get explore => 'រុករក';

  @override
  String get learnMore => 'ស្វែងយល់បន្ថែម';
}
