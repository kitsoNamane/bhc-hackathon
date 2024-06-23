class Customer {
  final String? uuid;
  final String? email;
  final String? phone;
  final bool? isExistingCustomer;

  Customer({this.phone, this.uuid, this.email, this.isExistingCustomer});

  Customer copyWith({
    String? uuid,
    String? email,
    String? phone,
    bool? isExistingCustomer,
  }) {
    return Customer(
      uuid: uuid ?? this.uuid,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isExistingCustomer: isExistingCustomer ?? this.isExistingCustomer,
    );
  }

  @override
  String toString() {
    return "email=$email, uuid=$uuid, phone=$phone, isExistingCustomer=$isExistingCustomer";
  }
 }