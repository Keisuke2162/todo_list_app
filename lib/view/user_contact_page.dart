import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactPage extends StatefulWidget {

  @override
  _ContactPage createState() => _ContactPage();
}

class _ContactPage extends State<ContactPage> {

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('お問い合わせ'),
      ),
      body: Column(
        children: [
          if(isLoading) LinearProgressIndicator(),
          Expanded(
            child: WebView(
              initialUrl: "https://docs.google.com/forms/d/e/1FAIpQLSeCmW3w-JX5iu-N7cexotOivwT806tH84jq9rdRtn3sGs0RnQ/viewform?usp=sf_link",
              // jsを有効化
              javascriptMode: JavascriptMode.unrestricted,
              // ページ読み込み開始
              onPageStarted: (String url) {
                setState(() {
                  isLoading = true;
                });
              },
              // ページ読み込み終了
              onPageFinished: (String url) async {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ),
        ],
      )
    );
  }
}