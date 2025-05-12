enum Env { development, test, production }

class Config {
  /// 通过打包运行时的环境变量，赋值接口环境
  static final Env env =
      Env.values.asNameMap()[const String.fromEnvironment("mode")] ??
      Env.development;
  // 是否是生产环境
  static bool get isProduction => env == Env.production;
  // 是否是测试环境
  static bool get isTest => env == Env.production;
  // 是否是本地开发环境
  static bool get isDevelopment => env == Env.production;

  /// api接口地址
  static String get apiHost {
    switch (env) {
      case Env.production:
        return "https://api.baidu.com";
      case Env.test:
        return 'https://test.api.baidu.com';
      case Env.development:
        return "http://192.168.31.254:4523/m1/2667762-0-default";
    }
  }

  /// 接口缓存的时间有效期，单位：微妙。2小时
  static final apiCacheTime = const Duration(hours: 2).inMicroseconds;

  /// 用户协议
  static const userProtocol = 'https://www.baidu.com';

  /// 隐私政策
  static const privacyPolicy = 'https://www.qq.com';
}
