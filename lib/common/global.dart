import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 全局变量
class Global {
  /// 持久化储存配置
  static late final SharedPreferences _prefs;

  /// 全局路由页面key
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 全局静态变量
  static String? token; // 用户鉴权
  static bool? agreement; // 隐私政策是否已同意

  /// 初始化持久化储存。
  /// 在初始化app之前执行
  static Future initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString("token");
    agreement = _prefs.getBool("agreement");
  }
  static SharedPreferences get prefs => _prefs;

  /// 进入app后的初始化。整个app生命周期仅执行一次
  static initData(BuildContext context) async {
    // TODO: 这里可以做一些初始化操作，比如获取用户信息
  }
}
