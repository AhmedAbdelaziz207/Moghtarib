import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.g.dart';


@JsonSerializable()
class CommentModel {
  int? id;
  int? apartmentId;
  String? userId;
  String? text;
  String? userName;

  CommentModel({
    this.id,
    this.apartmentId,
    this.userId,
    this.text,
    this.userName,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
/*
  {
    "id": 1148,
    "apartmentId": 1148,
    "userId": "76f88b97-6e28-4dde-b8c2-17414e80d510",
    "text": "dddd",
    "userName": "semsar2004"
  }
 */
