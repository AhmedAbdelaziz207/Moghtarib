import 'package:json_annotation/json_annotation.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';
import 'package:mo3tarib/features/register/model/UserModel.dart';

part 'apartment_comment.g.dart';

@JsonSerializable(explicitToJson: true)
class ApartmentComment {
  int? id;
  String? userId;
  int? apartmentId;
  String? text;
  DateTime? createdAt;
  ApartmentModel? apartment;
  UserModel? user;

  ApartmentComment({
    this.id,
    this.userId,
    this.apartmentId,
    this.text,
    this.createdAt,
    this.apartment,
    this.user,
  });

  factory ApartmentComment.fromJson(Map<String, dynamic> json) => _$ApartmentCommentFromJson(json);
  Map<String, dynamic> toJson() => _$ApartmentCommentToJson(this);
}