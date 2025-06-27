// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApartmentModel _$ApartmentModelFromJson(Map<String, dynamic> json) =>
    ApartmentModel(
      addressLat: (json['address_Lat'] as num?)?.toDouble(),
      addressLong: (json['address_Lon'] as num?)?.toDouble(),
      id: (json['id'] as num?)?.toInt(),
      city: json['city'] as String?,
      village: json['village'] as String?,
      location: json['location'] as String?,
      price: (json['price'] as num?)?.toInt(),
      numOfRooms: (json['numOfRooms'] as num?)?.toInt(),
      baseImageURL: json['baseImageURL'] as String?,
      type: (json['type'] as num?)?.toInt(),
      distanceByMeters: (json['distanceByMeters'] as num?)?.toInt(),
      isRent: json['isRent'] as bool?,
      dateOfCreation: json['dateOfCreation'] == null
          ? null
          : DateTime.parse(json['dateOfCreation'] as String),
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      userPhone: json['userPhone'] as String?,
      userWhatsapp: json['userWhatsapp'] as String?,
      imagesURL: (json['imagesURL'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ApartmentModelToJson(ApartmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'village': instance.village,
      'location': instance.location,
      'address_Lat': instance.addressLat,
      'address_Lon': instance.addressLong,
      'price': instance.price,
      'numOfRooms': instance.numOfRooms,
      'baseImageURL': instance.baseImageURL,
      'type': instance.type,
      'distanceByMeters': instance.distanceByMeters,
      'isRent': instance.isRent,
      'dateOfCreation': instance.dateOfCreation?.toIso8601String(),
      'userId': instance.userId,
      'userName': instance.userName,
      'userPhone': instance.userPhone,
      'userWhatsapp': instance.userWhatsapp,
      'imagesURL': instance.imagesURL,
    };
