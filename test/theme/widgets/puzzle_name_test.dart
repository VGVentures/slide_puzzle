// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzleName', () {
    late ThemeBloc themeBloc;
    late PuzzleTheme theme;

    const themeName = 'Name';

    setUp(() {
      themeBloc = MockThemeBloc();
      theme = MockPuzzleTheme();
      final themeState = MockThemeState();

      when(() => theme.name).thenReturn(themeName);
      when(() => themeState.theme).thenReturn(theme);
      when(() => themeBloc.state).thenReturn(themeState);
    });

    testWidgets(
        'renders theme name '
        'on a medium display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        PuzzleName(),
        themeBloc: themeBloc,
      );

      expect(find.text(themeName), findsOneWidget);
    });

    testWidgets(
        'renders an empty widget '
        'on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        PuzzleName(),
        themeBloc: themeBloc,
      );

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text(themeName), findsNothing);
    });

    testWidgets(
        'renders an empty widget '
        'on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        PuzzleName(),
        themeBloc: themeBloc,
      );

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text(themeName), findsNothing);
    });
  });
}
