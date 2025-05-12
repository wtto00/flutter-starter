# flutter_starter

一个flutter项目模板。

Flutter + Privder + Dio

## 开始前

1. 准备开发环境

   - JDK@17 (for Android)

1. 修改应用ID

   全局搜索 `com.exmaple` 并替换

1. 修改应用名称

   全局搜索 `flutter_starter` 并替换

## 目录结构

- assets/imgs: 图片位置
- assets/fonts: 图标、字体位置
- assets/lottie: lottie动画文件位置
- lib/common: 一些工具类，如通用方法类、网络接口类、保存全局变量的静态类等
- lib/models: Json文件对应的Dart Model类会在此目录下
- lib/routes: 存放所有路由页面类
- lib/states: 保存APP中需要跨组件共享的状态类
- lib/widgets: APP内封装的一些Widget组件都在该目录下

## 生成 part 子文件

```bash
# 一次性运行
dart run build_runner build --delete-conflicting-outputs

# 持续监听
dart run build_runner watch --delete-conflicting-outputs
```

## 打包

1. 测试环境

   ```bash
   # Android Apk
   flutter build apk --release --dart-define='mode=test' --obfuscate --split-debug-info=build/test_obfuscate_symbols_android

   # iOS
   flutter build ipa --release --dart-define='mode=test' --obfuscate --split-debug-info=build/test_obfuscate_symbols_ios
   ```

1. 生产环境

   ```bash
   # Android Apk
   flutter build apk --release --dart-define='mode=production' --obfuscate --split-debug-info=build/test_obfuscate_symbols_android

   # iOS
   flutter build ipa --release --dart-define='mode=production' --obfuscate --split-debug-info=build/test_obfuscate_symbols_ios

   ```

## 注意事项

1. webview_flutter 仅支持Android和iOS，其他平台不支持。
