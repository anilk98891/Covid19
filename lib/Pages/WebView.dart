import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class WebViewClass extends StatefulWidget {
  @override
  _WebViewClassState createState() => _WebViewClassState();
}

class _WebViewClassState extends State<WebViewClass> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Central Helpline Number"),
        backgroundColor: Colors.black,
      ),
      body: WebView(
        initialUrl: 'https://www.mohfw.gov.in/pdf/coronvavirushelplinenumber.pdf',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
