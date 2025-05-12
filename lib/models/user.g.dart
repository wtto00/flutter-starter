// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) =>
    User()
      ..uid = (json['uid'] as num?)?.toInt()
      ..nickname = json['nickname'] as String?
      ..avatar = json['avatar'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'uid': instance.uid,
  'nickname': instance.nickname,
  'avatar': instance.avatar,
};
