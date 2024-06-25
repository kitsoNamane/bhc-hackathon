
import 'package:json_annotation/json_annotation.dart';

part 'fault.g.dart';

@JsonSerializable()
class Fault {
  @JsonKey(name: "customer_id")
  final String? customerId;
  final String? description;
  final String? type;
  final String? incident;
  @JsonKey(name: "plot_number")
  final String? plotNumber;
  final String? email;
  final String? phone;
  final String? status;
  final String? severity;
  @JsonKey(name: "photo_url")
  final String? photoUrl;

  Fault({this.customerId, this.description, this.type, this.incident, this.plotNumber, this.email, this.phone, this.status, this.severity, this.photoUrl});

  factory Fault.fromJson(Map<String, dynamic> json) => _$FaultFromJson(json);

  Map<String, dynamic> toJson() => _$FaultToJson(this);
}
