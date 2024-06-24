// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      firstname: json['first_name'] as String?,
      lastname: json['last_name'] as String?,
      photoUrl: json['photo_url'] as String?,
      bhcPlotNumber: json['bhc_plot_number'] as String?,
      phone: json['phone'] as String?,
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      isExistingCustomer: json['is_existing_customer'] as bool?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'first_name': instance.firstname,
      'last_name': instance.lastname,
      'phone': instance.phone,
      'photo_url': instance.photoUrl,
      'bhc_plot_number': instance.bhcPlotNumber,
      'is_existing_customer': instance.isExistingCustomer,
    };
