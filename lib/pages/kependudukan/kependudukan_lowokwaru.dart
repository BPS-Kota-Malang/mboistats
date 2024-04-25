import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class PendudukLowokwaruPage extends StatefulWidget {
  const PendudukLowokwaruPage({Key? key}) : super(key: key);


  @override
  State<PendudukLowokwaruPage> createState() => _PendudukLowokwaruPageState();
}

class _PendudukLowokwaruPageState extends State<PendudukLowokwaruPage> {
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
    ..loadFlutterAssetServer('assets/web/kependudukan_lowokwaru.html');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kependudukan'),
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/back_kependudukan.png'),
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