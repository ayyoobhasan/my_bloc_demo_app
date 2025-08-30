import 'dart:convert';

class User {
  final int id;
  final String? name;
  final String? email;
  final Address? address;
  final bool isChanged; // default false

  User({
    required this.id,
    this.name,
    this.email,
    this.address,
    this.isChanged = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'],
      email: json['email'],
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : null,
      isChanged: false, // always false when coming from API
    );
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    Address? address,
    bool? isChanged,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      isChanged: isChanged ?? this.isChanged,
    );
  }
}

class Address {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;

  const Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
  });

  Address copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
  }) {
    return Address(
      street: street ?? this.street,
      suite: suite ?? this.suite,
      city: city ?? this.city,
      zipcode: zipcode ?? this.zipcode,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
      };
}

