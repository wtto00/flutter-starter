import 'package:flutter_starter/common/request.dart';
import 'package:flutter_starter/models/api_response.dart';
import 'package:flutter_starter/models/login_result.dart';

/// 查询用户信息
FutureResponse<LoginResult> queryUserInfo({bool? notGoLogin}) {
  return request(
    '/mine',
    resJsonParse: LoginResult.fromJson,
    notGoLogin: notGoLogin,
  );
}