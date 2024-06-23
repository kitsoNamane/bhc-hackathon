class Customer {
  final String? uuid;
  final String? email;
  final String? phone;

  Customer({this.phone, this.uuid, this.email});

  Customer copyWith({
    String? uuid,
    String? email,
    String? phone,
  }) {
    return Customer(
      uuid: uuid ?? this.uuid,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
 }