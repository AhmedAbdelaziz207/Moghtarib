import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  final String? firstName; // Nullable, maxLength: 20
  final String? lastName; // Nullable, maxLength: 20
  final String? userName; // Required, minLength: 1, maxLength: 60
  final String? email; // Required, minLength: 1, maxLength: 100, email format
  final String? nationalId; // Required, minLength: 14, maxLength: 14
  final String? phoneNumber; // Required, minLength: 1
  final String? whatsappNumber; // Required, minLength: 1
  @JsonKey(name: 'websiteURL')
  final String? websiteURL; // Nullable
  final String? password; // Required, minLength: 1
  @JsonKey(name: 'type')
  final String? role; // Required, minLength: 1
  final int? departmentId; // Nullable
  final String? addressLong;
  final String? addressLat;

  final double? distance;

  UserModel({
    this.addressLong,
    this.addressLat,
    this.distance,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.nationalId,
    this.phoneNumber,
    this.whatsappNumber,
    this.websiteURL,
    this.password,
    this.role,
    this.departmentId,
  });

  /// Factory method to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Method to convert instance to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
