import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
   NavigationControls({required this.controller, super.key});

   final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            if (await controller.canGoBack()) {
              controller.goBack();
            } else {
              messenger.showSnackBar(
                  const SnackBar(content: Text('No back history item')));
            }
            return;
          },
        ),
        IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              if (await controller.canGoForward()) {
                controller.goForward();
              } else {
                messenger.showSnackBar(
                    const SnackBar(content: Text('No Forward history item'))
                );
              }
              return;
            }),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () {
            controller.reload();
          },
        ),
      ],
    );
  }
}
