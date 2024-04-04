import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:flutter/services.dart';

class LuasPanenPadiPage extends StatelessWidget {

  WebViewControllerPlus controller = WebViewControllerPlus()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
          onProgress: (int progress) {
          // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
      ),
  )
  ..loadFlutterAssetServer('assets/web/pertanian_luas_panen_padi.html');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Luas Panen Padi'),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/left-arrow.png',
            height: 25,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/back_pertanian.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // WebView
          WebViewWidget(controller: controller),
        ],
      ),
    );
  }
}