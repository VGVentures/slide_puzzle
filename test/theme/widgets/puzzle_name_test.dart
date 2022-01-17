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
      final themeState = ThemeState(themes: [theme], theme: theme);

      when(() => theme.name).thenReturn(themeName);
      when(() => theme.nameColor).thenReturn(Colors.black);
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

    testWidgets('renders text in the given color', (tester) async {
      tester.setLargeDisplaySize();

      const color = Colors.purple;

      await tester.pumpApp(
        PuzzleName(color: color),
        themeBloc: themeBloc,
      );

      final textStyle = tester.firstWidget<AnimatedDefaultTextStyle>(
        find.byType(AnimatedDefaultTextStyle),
      );

      expect(textStyle.style.color, equals(color));
    });

    testWidgets(
        'renders text '
        'using PuzzleTheme.nameColor as text color '
        'if not provided', (tester) async {
      tester.setLargeDisplaySize();

      const nameColor = Colors.green;
      when(() => theme.nameColor).thenReturn(nameColor);

      await tester.pumpApp(
        PuzzleName(),
        themeBloc: themeBloc,
      );

      final textStyle = tester.firstWidget<AnimatedDefaultTextStyle>(
        find.byType(AnimatedDefaultTextStyle),
      );

      expect(textStyle.style.color, equals(nameColor));
    });
  });
}
