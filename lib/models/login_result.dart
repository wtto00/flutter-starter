import 'package:flutter_starter/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult extends User {
  LoginResult();

  @JsonKey(name: 'access_token')
  String? accessToken;

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}