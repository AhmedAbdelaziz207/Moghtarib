import 'package:json_annotation/json_annotation.dart';

part 'register_repsonse.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String? token;
  final String? userName;
  final String? role;
  final String? id;
  final String? email;

  RegisterResponse({
    this.email,
    this.token,
    this.userName,
    this.role,
    this.id,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
