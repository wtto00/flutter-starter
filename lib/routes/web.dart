import 'package:flutter/material.dart';
import 'package:flutter_starter/states/web.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {
  const Web({super.key});

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                debugPrint("web-page onProgress: $progress");
                context.read<WebProvider>().progress = progress;
              },
              onPageStarted: (String url) {
                debugPrint("web-page onPageStarted: $url");
              },
              onPageFinished: (String url) {
                debugPrint("web-page onPageFinished: $url");
                controller.getTitle().then(
                  (value) =>
                      mounted
                          ? context.read<WebProvider>().title = value
                          : null,
                );
              },
              onHttpError: (HttpResponseError error) {
                debugPrint("web-page onHttpError: $error");
              },
              onWebResourceError: (WebResourceError error) {
                debugPrint("web-page onWebResourceError: $error");
              },
              onNavigationRequest: (NavigationRequest request) {
                // if (request.url.startsWith('https://www.youtube.com/')) {
                //   return NavigationDecision.prevent;
                // }
                return NavigationDecision.navigate;
              },
            ),
          );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      String url =
          (ModalRoute.of(context)?.settings.arguments
              as Map<String, String>?)?['url'] ??
          '';
      controller.loadRequest(Uri.parse(url));
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("web-page build");
    return Scaffold(
      appBar: AppBar(
        title: Selector<WebProvider, String>(
          selector: (context, provider) => provider.title,
          builder: (context, title, child) => Text(title),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Selector<WebProvider, int>(
            builder:
                (context, progress, child) => Visibility(
                  visible: progress < 100,
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
            selector: (context, provider) => provider.progress,
          ),
          Expanded(child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}
