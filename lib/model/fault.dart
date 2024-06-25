
import 'package:json_annotation/json_annotation.dart';

part 'fault.g.dart';

@JsonSerializable(includeIfNull: false)
class Fault {
  final int? id;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "fault_occured_at")
  final String? faultOccuredAt;
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

  Fault({this.id, this.createdAt, this.faultOccuredAt, this.customerId, this.description, this.type, this.incident, this.plotNumber, this.email, this.phone, this.status, this.severity, this.photoUrl});

  factory Fault.fromJson(Map<String, dynamic> json) => _$FaultFromJson(json);

  Map<String, dynamic> toJson() => _$FaultToJson(this);

  @override
  String toString() {
    return "Fault("
        "id=$id,"
        "email=$email,"
        "customer_id=$customerId,"
        "phone=$phone,"
        "photo_url=$photoUrl,"
        "type=$type,"
        "incident=$incident,"
        "status=$status,"
        "severity=$severity,"
        "plot_number=$plotNumber,"
        "description=$description,"
        "created_at=$createdAt,"
        ")";
  }
}
