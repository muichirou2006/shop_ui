import 'package:flutter/material.dart';

enum DeliveryMethod {
  standard(
      'Standard delivery', '3–5 business days', Icons.local_shipping_outlined),
  express('Express delivery', '1–2 business days', Icons.bolt_rounded);

  const DeliveryMethod(this.title, this.eta, this.icon);

  final String title;
  final String eta;
  final IconData icon;
}

enum PaymentMethod {
  card('Credit / debit card', Icons.credit_card_rounded),
  wallet('Digital wallet', Icons.account_balance_wallet_outlined),
  cash('Cash on delivery', Icons.payments_outlined);

  const PaymentMethod(this.title, this.icon);

  final String title;
  final IconData icon;
}
