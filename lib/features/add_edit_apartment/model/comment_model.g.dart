// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: (json['id'] as num?)?.toInt(),
      apartmentId: (json['apartmentId'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      text: json['text'] as String?,
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'apartmentId': instance.apartmentId,
      'userId': instance.userId,
      'text': instance.text,
      'userName': instance.userName,
    };
