# webview_in_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## issue resolved

I came across this error

[issue solution](<https://github.com/flutter/flutter/issues/121412>)

[A related issue](<https://github.com/flutter/flutter/issues/120017>)

══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞═══════════════════════════════════════════════════════════
The following assertion was thrown building Builder:
A platform implementation for `webview_flutter` has not been set. Please ensure that an
implementation of `WebViewPlatform` has been set to `WebViewPlatform.instance` before use. For unit
testing, `WebViewPlatform.instance` can be set with your own test implementation.
'package:webview_flutter_platform_interface/src/platform_webview_controller.dart':
Failed assertion: line 25 pos 7: 'WebViewPlatform.instance != null'

[tried this didn't work](<https://github.com/flutter/flutter/issues/108801#issuecomment-1367490174>)

## Note  

every feature that uses runJvascriptReturnResult is not working

the methods for modifying cookies aren't working

the methods for viewing the assets aren't working

error has been resolved it turns out i had these errors because i did not create a field in the controller and pass the controller with the settings from the menu.dart , i just initialized a new one which had no settings
