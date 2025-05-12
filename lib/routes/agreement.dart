import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/common/global.dart';

class Agreement extends StatefulWidget {
  const Agreement({super.key});

  @override
  State<Agreement> createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAgreement();
    });
  }

  _showAgreement() {
    const fontSpace = WidgetSpan(child: SizedBox(width: 28));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          // title: const Text(
          //   "用户隐私保护提示",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          // ),
          // backgroundColor: Colors.white,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(12),
          // ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          content: Container(
            constraints: const BoxConstraints(maxWidth: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "用户隐私保护提示",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              fontSpace,
                              const TextSpan(
                                text: "追书神器非常重视您的个人信息和隐私保护。根据国家相关法律规定和标准更新了",
                              ),
                              TextSpan(
                                text: "《追书神器免费版用户协议》",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushNamed(
                                          "web",
                                          arguments: {
                                            "url":
                                                "https://www.zhuishushenqi.com/agreement",
                                          },
                                        );
                                      },
                              ),
                              const TextSpan(text: "和"),
                              TextSpan(
                                text: "《追书神器免费版用户隐私保护政策》",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushNamed(
                                          "web",
                                          arguments: {
                                            "url":
                                                "https://www.zhuishushenqi.com/privacy",
                                          },
                                        );
                                      },
                              ),
                              const TextSpan(text: "，请您在使用前仔细阅读并了解所有条款，包括："),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              fontSpace,
                              const TextSpan(
                                text:
                                    "1、为向您提供包括账户注册、图书阅读、交易支付在内的基本功能，我们可能会基于具体业务场景收集您的个人信息；",
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              fontSpace,
                              const TextSpan(
                                text:
                                    "2、为向您提供包括账户注册、图书阅读、交易支付在内的基本功能，我们可能会基于具体业务场景收集您的个人信息；",
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              fontSpace,
                              const TextSpan(
                                text:
                                    "3、为向您提供包括账户注册、图书阅读、交易支付在内的基本功能，我们可能会基于具体业务场景收集您的个人信息；",
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              fontSpace,
                              const TextSpan(
                                text:
                                    "4、为向您提供包括账户注册、图书阅读、交易支付在内的基本功能，我们可能会基于具体业务场景收集您的个人信息；",
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              fontSpace,
                              const TextSpan(
                                text:
                                    "5、为向您提供包括账户注册、图书阅读、交易支付在内的基本功能，我们可能会基于具体业务场景收集您的个人信息；",
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              fontSpace,
                              const TextSpan(
                                text:
                                    "6、为向您提供包括账户注册、图书阅读、交易支付在内的基本功能，我们可能会基于具体业务场景收集您的个人信息；",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 32,
                  child: FilledButton(
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        const EdgeInsets.symmetric(horizontal: 52, vertical: 4),
                      ),
                    ),
                    onPressed: () {
                      Global.prefs.setBool("agreement", true);
                      Global.agreement = true;
                      Global.initData(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'home',
                        (route) => false,
                      );
                    },
                    child: const Text("同意并进入"),
                  ),
                ),
                SizedBox(height: 4),
                SizedBox(
                  height: 24,
                  child: TextButton(
                    onPressed: () {
                      // 不同意隐私协议，退出应用
                      exit(0);
                    },
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.grey),
                      padding: WidgetStatePropertyAll(const EdgeInsets.all(0)),
                    ),
                    child: const Text("不同意", style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
