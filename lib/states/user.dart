import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_starter/apis/user.dart';
import 'package:flutter_starter/common/global.dart';
import 'package:flutter_starter/models/login_result.dart';
import 'package:flutter_starter/models/user.dart';

/// user provider
class UserProvider extends ChangeNotifier {
  int? _uid;
  String? _avatar;
  String? _nickname;

  int get uid => _uid ?? 0;
  String get avatar => _avatar ?? '';
  String get nickname => _nickname ?? (isLogin ? '匿名用户' : '未登录');

  /// 是否登录
  bool get isLogin => _uid != null && _uid! > 0;

  /// 设置用户信息
  void setUser(User data) {
    _uid = data.uid;
    _avatar = data.avatar;
    _nickname = data.nickname;
    notifyListeners();
  }

  /// 是否已初始化过用户信息。
  /// 没有token的话，也算初始化过
  final Completer<bool> _completer = Completer();
  Future<bool> get inited => _completer.future;
  void completerInited(bool isInited) {
    if (_completer.isCompleted) return;
    _completer.complete(isInited);
  }

  /// 登录成功之后的操作
  void afterLoginSuccess(BuildContext context, LoginResult result) {
    Global.token = result.accessToken;
    setUser(result);
    // 可以返回就返回，不可以返回就重定向到首页
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, 'main_page');
    }
  }

  /// 请求用户信息
  /// [notGoLogin] 默认鉴权失败，会跳转登录页面
  /// [0] token为空时返回
  /// [1] 接口请求成功
  /// [-1] 接口请求失败
  Future<int> initUserInfo(
    BuildContext context, {
    bool notGoLogin = false,
  }) async {
    if (Global.token?.isNotEmpty == true) {
      final res = await queryUserInfo(notGoLogin: notGoLogin);
      if (res.code != null) return -1;
      setUser(res.data!);
      return 1;
    }
    return 0;
  }
}
