// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      (json['id'] as num?)?.toInt(),
      (json['fault_id'] as num?)?.toInt(),
      json['created_at'] as String?,
      json['customer_id'] as String?,
      json['status'] as String?,
      (json['amount'] as num?)?.toInt(),
      json['client_secret'] as String?,
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
