// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) =>
    LoginResult()
      ..uid = (json['uid'] as num?)?.toInt()
      ..nickname = json['nickname'] as String?
      ..avatar = json['avatar'] as String?
      ..accessToken = json['access_token'] as String?;

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'access_token': instance.accessToken,
    };
