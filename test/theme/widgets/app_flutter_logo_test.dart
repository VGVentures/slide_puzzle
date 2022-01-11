// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AppFlutterLogo', () {
    testWidgets('renders on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(AppFlutterLogo());

      expect(
        find.byType(Image),
        findsOneWidget,
      );
    });

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(AppFlutterLogo());

      expect(
        find.byType(Image),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(AppFlutterLogo());

      expect(
        find.byType(Image),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders colored Image '
        'when isColored is true', (tester) async {
      await tester.pumpApp(
        AppFlutterLogo(
          isColored: true,
          height: 18,
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              (widget.image as AssetImage).assetName ==
                  'assets/images/logo_flutter_color.png',
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders white Image '
        'when isColored is false', (tester) async {
      await tester.pumpApp(
        AppFlutterLogo(
          isColored: false,
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              (widget.image as AssetImage).assetName ==
                  'assets/images/logo_flutter_white.png',
        ),
        findsOneWidget,
      );
    });
  });
}
