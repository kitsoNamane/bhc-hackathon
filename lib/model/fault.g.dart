// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fault.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fault _$FaultFromJson(Map<String, dynamic> json) => Fault(
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

Map<String, dynamic> _$FaultToJson(Fault instance) => <String, dynamic>{
      'customer_id': instance.customerId,
      'description': instance.description,
      'type': instance.type,
      'incident': instance.incident,
      'plot_number': instance.plotNumber,
      'email': instance.email,
      'phone': instance.phone,
      'status': instance.status,
      'severity': instance.severity,
      'photo_url': instance.photoUrl,
    };
