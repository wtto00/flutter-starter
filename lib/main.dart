import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_starter/common/global.dart';
import 'package:flutter_starter/common/theme_color.dart';
import 'package:flutter_starter/routes/agreement.dart';
import 'package:flutter_starter/routes/main_page.dart';
import 'package:flutter_starter/routes/web.dart';
import 'package:flutter_starter/states/main_page.dart';
import 'package:flutter_starter/states/user.dart';
import 'package:flutter_starter/states/web.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Global.initPreferences().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Global.agreement == true) {
        // 如果隐私协议已同意，则进入app时，初始化相关数据
        Global.initData(context);
      }
    });
  }

  // 安卓两次物理返回退出app
  DateTime? _lastPopTime;
  _onPopInvokedWithResult(bool didPop, result) {
    if (_lastPopTime == null ||
        _lastPopTime!.isBefore(
          DateTime.now().subtract(const Duration(milliseconds: 1500)),
        )) {
      showToast('再按一次退出');
      _lastPopTime = DateTime.now();
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // 全局响应式变量
      providers: [
        // 用户信息
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // ...其他全局响应式数据
      ],
      child: OKToast(
        position: ToastPosition.bottom,
        child: MaterialApp(
          title: 'flutter_starter',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: ThemeColor.primary,
              accentColor: ThemeColor.primary,
              brightness: Brightness.light,
            ),
          ),
          supportedLocales: [const Locale('zh', 'CN')],
          locale: const Locale('zh', 'CN'),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          initialRoute: Global.agreement == true ? 'home' : 'agreement',
          routes: {
            'agreement': (_) => const Agreement(),
            'home':
                (_) => PopScope(
                  canPop: false,
                  onPopInvokedWithResult: _onPopInvokedWithResult,
                  child: ChangeNotifierProvider(
                    create: (_) => MainPageProvider(),
                    child: const MainPage(),
                  ),
                ),
            'web':
                (_) => ChangeNotifierProvider(
                  create: (_) => WebProvider(),
                  child: const Web(),
                ),
          },
          navigatorKey: Global.navigatorKey,
        ),
      ),
    );
  }
}
