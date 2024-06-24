
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  final String? uuid;
  final String? email;
  @JsonKey(name: "first_name")
  final String? firstName;
  @JsonKey(name: "last_name")
  final String? lastName;
  final String? phone;
  @JsonKey(name: "photo_url")
  final String? photoUrl;
  @JsonKey(name: "bhc_plot_number")
  final String? bhcPlotNumber;
  @JsonKey(name: "is_existing_customer")
  final bool? isExistingCustomer;

  Customer({this.firstName, this.lastName, this.photoUrl, this.bhcPlotNumber, this.phone, this.uuid, this.email, this.isExistingCustomer});

  Customer copyWith({
    String? uuid,
    String? email,
    String? phone,
    String? photoUrl,
    String? firstName,
    String? lastName,
    String? bhcPlotNumber,
    bool? isExistingCustomer,
  }) {
    return Customer(
      uuid: uuid ?? this.uuid,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bhcPlotNumber: bhcPlotNumber ?? this.bhcPlotNumber,
      isExistingCustomer: isExistingCustomer ?? this.isExistingCustomer,
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  String toString() {
    return "email=$email, uuid=$uuid, phone=$phone, isExistingCustomer=$isExistingCustomer";
  }
 }