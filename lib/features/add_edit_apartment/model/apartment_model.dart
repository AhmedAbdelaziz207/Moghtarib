import 'package:json_annotation/json_annotation.dart';

part 'apartment_model.g.dart';

@JsonSerializable()
class ApartmentModel {
  final int? id;
  final String? city;
  final String? village;
  final String? location;
  @JsonKey(name: 'address_Lat')
  final double? addressLat;
  @JsonKey(name: 'address_Lon')
  final double? addressLong;
  final int? price;
  final int? numOfRooms;
  final String? baseImageURL;
  final int? type;
  final int? distanceByMeters;
  final bool? isRent;
  final DateTime? dateOfCreation;
  final String? userId;
  final String? userName;
  final String? userPhone;
  final String? userWhatsapp;
  final List<String>? imagesURL;

  ApartmentModel({
    this.addressLat,
    this.addressLong,
    this.id,
    this.city,
    this.village,
    this.location,
    this.price,
    this.numOfRooms,
    this.baseImageURL,
    this.type,
    this.distanceByMeters,
    this.isRent,
    this.dateOfCreation,
    this.userId,
    this.userName,
    this.userPhone,
    this.userWhatsapp,
    this.imagesURL,
  });

  factory ApartmentModel.fromJson(Map<String, dynamic> json) =>
      _$ApartmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApartmentModelToJson(this);
}
/*
{
    "id": 0,
    "city": "string",
    "village": "string",
    "location": "string",
    "address_Lat": 0,
    "address_Lon": 0,
    "price": 0,
    "numOfRooms": 0,
    "baseImageURL": "string",
    "type": 1,
    "distanceByMeters": 0,
    "isRent": true,
    "dateOfCreation": "2025-06-08T16:19:55.194Z",
    "userId": "string",
    "userName": "string",
    "userPhone": "string",
    "userWhatsapp": "string",
    "imagesURL": [
      "string"
    ]
  }
 */
