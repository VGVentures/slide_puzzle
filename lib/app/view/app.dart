// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    Future<void>.delayed(const Duration(milliseconds: 20), () {
      for (var i = 1; i <= 15; i++) {
        precacheImage(
          Image.asset('assets/images/dashatar/green/$i.png').image,
          context,
        );
        precacheImage(
          Image.asset('assets/images/dashatar/blue/$i.png').image,
          context,
        );
        precacheImage(
          Image.asset('assets/images/dashatar/yellow/$i.png').image,
          context,
        );
      }
      precacheImage(
        Image.asset('assets/images/dashatar/gallery/green.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/dashatar/success/green.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/dashatar/gallery/blue.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/dashatar/success/blue.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/dashatar/gallery/yellow.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/dashatar/success/yellow.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/logo_flutter_color.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/logo_flutter_white.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/shuffle_icon.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/timer_icon.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/simple_dash_large.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/simple_dash_medium.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/simple_dash_small.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/twitter_icon.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/facebook_icon.png').image,
        context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const PuzzlePage(),
    );
  }
}
