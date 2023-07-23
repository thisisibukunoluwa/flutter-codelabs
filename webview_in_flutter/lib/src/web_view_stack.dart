import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key});

  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;
  Uri uri = Uri.parse('https://flutter.dev');

  late final Future<WebViewController> _initWebViewFuture;

  late final NavigationDelegate _navigationDelegate;

  @override
  void initState() {
    super.initState();
    _initWebViewFuture = _initWebView();
  }

  Future<WebViewController> _initWebView() async {
    _navigationDelegate = NavigationDelegate(
      onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
      },
      onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      },
      onPageFinished: (progress) async {
        setState(() {
          loadingPercentage = 100;
        });
      },
      onNavigationRequest: (navigation) {
        final host = Uri.parse(navigation.url).host;
        if (host.contains('youtube.com')) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Blocking navigation to $host')));
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
    WebViewController controller =  widget.controller;

    await controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    await controller.addJavaScriptChannel('SnackBar',
        onMessageReceived: (message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message.message)));
    });
    await controller.setNavigationDelegate(_navigationDelegate);

    await controller.loadRequest(uri);

    return Future.value(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: FutureBuilder<WebViewController>(
      future: _initWebViewFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WebViewWidget(controller: widget.controller);
        } else if (snapshot.hasError) {
          return const Center(child: Text('Webview Initialization error'));
        } else {
          return Center(
            child: CircularProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
          );
        }
      },
    )
 );
}
}
