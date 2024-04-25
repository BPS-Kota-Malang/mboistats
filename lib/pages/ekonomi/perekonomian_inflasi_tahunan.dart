import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class InflasiTahunanPage extends StatelessWidget {

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
    ..loadFlutterAssetServer('assets/web/perekonomian_inflasi_tahunan.html');

  InflasiTahunanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inflasi Tahun Kalender'),
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
                image: AssetImage('assets/images/back_perekonomian.png'),
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