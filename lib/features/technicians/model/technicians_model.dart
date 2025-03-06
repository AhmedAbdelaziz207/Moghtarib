import 'package:json_annotation/json_annotation.dart';
part 'technicians_model.g.dart';

@JsonSerializable()
class TechnicalsModel {
  final String? id;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? nationalId;
  final String? whatsappNumber;
  final String? websiteURL;
  final String? type;
  final int? departmentId;
  final String? departmentName;
  final String? phoneNumber;

  TechnicalsModel({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.nationalId,
    this.whatsappNumber,
    this.websiteURL,
    this.type,
    this.departmentId,
    this.departmentName,
    this.phoneNumber,
  });

  factory TechnicalsModel.fromJson(Map<String, dynamic> json) =>
      _$TechnicalsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicalsModelToJson(this);
}
