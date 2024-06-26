// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: (json['id'] as num?)?.toInt(),
      faultId: (json['fault_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      customerId: json['customer_id'] as String?,
      status: json['status'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      clientSecret: json['client_secret'] as String?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('fault_id', instance.faultId);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('customer_id', instance.customerId);
  writeNotNull('status', instance.status);
  writeNotNull('amount', instance.amount);
  writeNotNull('client_secret', instance.clientSecret);
  return val;
}
