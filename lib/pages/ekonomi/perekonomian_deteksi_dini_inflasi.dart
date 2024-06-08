import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class DeteksiDiniInflasiPage extends StatefulWidget {


  const DeteksiDiniInflasiPage({Key? key}) : super(key: key);

  @override
  State<DeteksiDiniInflasiPage> createState() => _DeteksiDiniInflasiPageState();
}

class _DeteksiDiniInflasiPageState extends State<DeteksiDiniInflasiPage> {
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
    ..loadRequest(Uri.parse('https://inflasi.bpskotamalang.id'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deteksi Dini Inflasi'),
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