
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
  @JsonKey(name: "payment_status")
  final String? paymentStatus;
  final String? severity;
  @JsonKey(name: "photo_url")
  final String? photoUrl;

  Fault({this.id, this.createdAt, this.paymentStatus, this.faultOccuredAt, this.customerId, this.description, this.type, this.incident, this.plotNumber, this.email, this.phone, this.status, this.severity, this.photoUrl});

  factory Fault.fromJson(Map<String, dynamic> json) => _$FaultFromJson(json);

  Map<String, dynamic> toJson() => _$FaultToJson(this);

  Fault copyWith({
  final int? id,
  final String? createdAt,
  final String? faultOccuredAt,
  final String? customerId,
  final String? description,
  final String? type,
  final String? incident,
  final String? plotNumber,
  final String? email,
  final String? phone,
  final String? status,
  final String? paymentStatus,
  final String? severity,
  final String? photoUrl,
  }) {
    return Fault(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      faultOccuredAt: faultOccuredAt ?? this.faultOccuredAt,
      customerId: customerId ?? this.customerId,
      description: createdAt ?? this.description,
      type: type ?? this.type,
      incident: incident ?? this.incident,
      plotNumber: plotNumber ?? this.plotNumber,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      severity: severity ?? this.severity,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

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
        "payment_status=$paymentStatus,"
        "severity=$severity,"
        "plot_number=$plotNumber,"
        "description=$description,"
        "created_at=$createdAt,"
        ")";
  }
}