// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      departmentName: json['departmentName'] as String?,
      addressLong: json['addressLong'] as String?,
      addressLat: json['addressLat'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      nationalId: json['nationalId'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      whatsappNumber: json['whatsappNumber'] as String?,
      websiteURL: json['websiteURL'] as String?,
      password: json['password'] as String?,
      role: json['type'] as String?,
      departmentId: (json['departmentId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
      'email': instance.email,
      'nationalId': instance.nationalId,
      'phoneNumber': instance.phoneNumber,
      'whatsappNumber': instance.whatsappNumber,
      'websiteURL': instance.websiteURL,
      'password': instance.password,
      'type': instance.role,
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'addressLong': instance.addressLong,
      'addressLat': instance.addressLat,
      'distance': instance.distance,
    };
