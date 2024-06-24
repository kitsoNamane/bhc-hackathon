
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  @JsonKey(name: "uid")
  final String? uuid;
  final String? email;
  @JsonKey(name: "first_name")
  final String? firstname;
  @JsonKey(name: "last_name")
  final String? lastname;
  final String? phone;
  @JsonKey(name: "photo_url")
  final String? photoUrl;
  @JsonKey(name: "bhc_plot_number")
  final String? bhcPlotNumber;
  @JsonKey(name: "is_existing_customer")
  final bool? isExistingCustomer;

  Customer({this.firstname, this.lastname, this.photoUrl, this.bhcPlotNumber, this.phone, this.uuid, this.email, this.isExistingCustomer});

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
      firstname: firstName ?? this.firstname,
      lastname: lastName ?? this.lastname,
      bhcPlotNumber: bhcPlotNumber ?? this.bhcPlotNumber,
      isExistingCustomer: isExistingCustomer ?? this.isExistingCustomer,
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  String toString() {
    return "Customer("
        "email=$email,"
        "uuid=$uuid,"
        "phone=$phone,"
        "photoUrl=$photoUrl,"
        "firstname=$firstname,"
        "lastname=$lastname,"
        "bhcPlotNumber=$bhcPlotNumber,"
        "isExistingCustomer=$isExistingCustomer,"
        ")";
  }
 }