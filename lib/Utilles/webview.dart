

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/primaryActions.dart';

class webview  extends StatefulWidget {

  var url;

  webview(this.url);

  @override
  State<webview> createState() => _webviewState(url);
}

class _webviewState extends State<webview> {

  _webviewState(url);

  InAppWebViewController? webViewController;
  double progress = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: appcolors.primaryColor,
        leadingWidth: 20.0,
        iconTheme: IconThemeData(color:appcolors.whiteColor),
        title: Image.asset('assets/icons/yuvasathi_purewhite.png',width: 120,height: 40,fit:BoxFit.fill),
        actions: [primaryActions()],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse('${widget.url}')),
            onProgressChanged: (controller, progress) {
              setState(() {
                print('fffffffff${widget.url}');
                this.progress = progress / 100;
              });
            },
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
          ),
          LinearProgressIndicator(
            value: progress,
            color: Colors.green,
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
