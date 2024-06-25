// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fault.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fault _$FaultFromJson(Map<String, dynamic> json) => Fault(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      customerId: json['customer_id'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      incident: json['incident'] as String?,
      plotNumber: json['plot_number'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      status: json['status'] as String?,
      severity: json['severity'] as String?,
      photoUrl: json['photo_url'] as String?,
    );

Map<String, dynamic> _$FaultToJson(Fault instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('customer_id', instance.customerId);
  writeNotNull('description', instance.description);
  writeNotNull('type', instance.type);
  writeNotNull('incident', instance.incident);
  writeNotNull('plot_number', instance.plotNumber);
  writeNotNull('email', instance.email);
  writeNotNull('phone', instance.phone);
  writeNotNull('status', instance.status);
  writeNotNull('severity', instance.severity);
  writeNotNull('photo_url', instance.photoUrl);
  return val;
}
