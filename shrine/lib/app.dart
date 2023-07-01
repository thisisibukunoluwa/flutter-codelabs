import 'package:flutter/material.dart';
import 'package:shrine/colors.dart';
import 'package:shrine/home.dart';
import 'package:shrine/login.dart';

final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
    primary: kShrinePink100,
    onPrimary: kShrineBrown900,
    secondary: kShrineBrown900,
    error: kShrineErrorRed,
  ),
  textTheme: _buildShrineTextTheme(base.textTheme),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: kShrinePink100
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width:2.0,color: kShrineBrown900)
    ),
    floatingLabelStyle: TextStyle(
      color: kShrineBrown900
    )
  ),
);
}

// this takes a text theme and changes how headlines,titles and captions look
//Applying the fontFamily in this way applies the changes only to the typography scale values specified in copyWith() (headline, title, caption).
// For some fonts, we're setting a custom fontWeight, in increments of 100: w500 (the 500 weight) corresponds to medium and w400 corresponds to regular.

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
          headlineSmall:
              base.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
          titleLarge: base.titleLarge!.copyWith(fontSize: 18.0),
          bodySmall: base.bodySmall!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 14.0),
          bodyLarge: base.bodyLarge!
              .copyWith(fontWeight: FontWeight.w500, fontSize: 16.0))
      .apply(
          fontFamily: 'Rubik',
          displayColor: kShrineBrown900,
          bodyColor: kShrineBrown900);
}

class ShrineApp extends StatelessWidget {
  const ShrineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shrine',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const HomePage()
      },
      theme: _kShrineTheme,
    );
  }
}
