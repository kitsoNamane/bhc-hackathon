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

  Payment(
      {this.id,
      this.faultId,
      this.createdAt,
      this.customerId,
      this.status,
      this.amount,
      this.clientSecret});

  Payment copyWith({
    final int? id,
    final int? faultId,
    final String? createdAt,
    final String? customerId,
    final String? status,
    final int? amount,
    final String? clientSecret,
  }) {
    return Payment(
        id: id ?? this.id,
        faultId: faultId ?? this.faultId,
        createdAt: createdAt ?? this.createdAt,
        customerId: customerId ?? this.customerId,
        status: status ?? this.status,
        amount: amount ?? this.amount,
        clientSecret: clientSecret ?? this.clientSecret);
  }

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
