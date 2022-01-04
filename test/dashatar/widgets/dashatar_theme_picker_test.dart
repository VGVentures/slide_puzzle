// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarThemePicker', () {
    late DashatarThemeBloc dashatarThemeBloc;
    late DashatarTheme dashatarTheme;
    late List<DashatarTheme> dashatarThemes;

    setUp(() {
      dashatarThemeBloc = MockDashatarThemeBloc();
      dashatarThemes = [
        GreenDashatarTheme(),
        YellowDashatarTheme(),
        BlueDashatarTheme()
      ];
      dashatarTheme = GreenDashatarTheme();
      final dashatarThemeState = DashatarThemeState(
        themes: dashatarThemes,
        theme: dashatarTheme,
      );

      when(() => dashatarThemeBloc.state).thenReturn(dashatarThemeState);
    });

    testWidgets('renders on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
      );

      expect(
        find.byKey(Key('dashatar_theme_picker')),
        findsOneWidget,
      );
    });

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
      );

      expect(
        find.byKey(Key('dashatar_theme_picker')),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
      );

      expect(
        find.byKey(Key('dashatar_theme_picker')),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders Image with a theme asset '
        'for each Dashatar theme', (tester) async {
      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
      );

      for (final dashatarTheme in dashatarThemes) {
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Image &&
                (widget.image as AssetImage).assetName ==
                    dashatarTheme.themeAsset,
          ),
          findsOneWidget,
        );
      }
    });

    testWidgets(
        'adds DashatarThemeChanged to DashatarThemeBloc '
        'when tapped', (tester) async {
      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
      );

      final index = dashatarThemes.indexOf(GreenDashatarTheme());

      await tester.tap(find.byKey(Key('dashatar_theme_picker_$index')));

      verify(
        () => dashatarThemeBloc.add(DashatarThemeChanged(themeIndex: index)),
      ).called(1);
    });
  });
}
