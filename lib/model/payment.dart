
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable(includeIfNull: false)
class Payment {
  final int? id;
  @JsonKey(name: "fault_id")
  final int? faultId;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "customer_id")
  final String? customerId;
  final String? status;
  final int? amount;
  @JsonKey(name: "client_secret")
  final String? clientSecret;

  Payment({this.id, this.faultId, this.createdAt, this.customerId, this.status, this.amount, this.clientSecret});

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}