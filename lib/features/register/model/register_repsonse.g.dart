// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_repsonse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      email: json['email'] as String?,
      token: json['token'] as String?,
      userName: json['userName'] as String?,
      role: json['role'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userName': instance.userName,
      'role': instance.role,
      'id': instance.id,
      'email': instance.email,
    };
