import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class PengangguranMenurutPendidikan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengangguran Menurut Pendidikan'),
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
      body: WebView(
        initialUrl: 'about:blank',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          // Load HTML content from the file
          final String path = 'assets/html/ketenagakerjaan_penganggur_pendidikan.html';
          final String fileHtmlContents =
              await rootBundle.loadString(path);

          // Load HTML into the WebView
          webViewController.loadUrl(
            Uri.dataFromString(
              fileHtmlContents,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString(),
          );
        },
      ),
    );
  }
}