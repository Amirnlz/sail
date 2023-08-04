import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as webview;

import '../constant/app_strings.dart';

class WebViewWidget extends StatefulWidget {
  final String? url;
  final String? name;

  const WebViewWidget({Key? key, this.url, this.name}) : super(key: key);

  @override
  WebViewWidgetState createState() => WebViewWidgetState();
}

class WebViewWidgetState extends State<WebViewWidget> {
  late webview.WebViewController controller;

  final String _javaScript = '''
  const styles = `
  #page-header {
    display: none;
  }
  #main-container {
    padding-top: 0 !important;
  }
  `
  const styleSheet = document.createElement("style")
  styleSheet.innerText = styles
  document.head.appendChild(styleSheet)
  ''';

  @override
  void initState() {
    super.initState();
    final webViewUrl = widget.url?.isEmpty == true
        ? AppStrings.appName
        : widget.url ?? 'google.com';

    controller = webview.WebViewController()
      ..loadRequest(Uri.parse(webViewUrl))
      ..setJavaScriptMode(webview.JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        webview.NavigationDelegate(
          onPageFinished: (url) {
            debugPrint('url=$url');
            controller.runJavaScript(_javaScript);
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name!),
        centerTitle: true,
      ),
      body: webview.WebViewWidget(
        controller: controller,
      ),
    );
  }
}
