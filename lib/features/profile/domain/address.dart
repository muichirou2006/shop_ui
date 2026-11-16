import 'package:flutter/foundation.dart';

@immutable
class Address {
  const Address({
    required this.id,
    required this.label,
    required this.recipient,
    required this.street,
    required this.city,
    this.isDefault = false,
  });

  final String id;
  final String label;
  final String recipient;
  final String street;
  final String city;
  final bool isDefault;

  Address copyWith({bool? isDefault}) => Address(
        id: id,
        label: label,
        recipient: recipient,
        street: street,
        city: city,
        isDefault: isDefault ?? this.isDefault,
      );
}
