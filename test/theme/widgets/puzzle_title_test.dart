// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzleTitle', () {
    late ThemeBloc themeBloc;
    late PuzzleTheme theme;

    setUp(() {
      themeBloc = MockThemeBloc();
      theme = MockPuzzleTheme();
      final themeState = ThemeState(themes: [theme], theme: theme);

      when(() => theme.titleColor).thenReturn(Colors.black);
      when(() => themeBloc.state).thenReturn(themeState);
    });

    testWidgets('renders on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        PuzzleTitle(title: 'Title'),
        themeBloc: themeBloc,
      );

      expect(
        find.text('Title'),
        findsOneWidget,
      );
    });

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        PuzzleTitle(title: 'Title'),
        themeBloc: themeBloc,
      );

      expect(
        find.text('Title'),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        PuzzleTitle(title: 'Title'),
        themeBloc: themeBloc,
      );

      expect(
        find.text('Title'),
        findsOneWidget,
      );
    });

    testWidgets('renders text in the given color', (tester) async {
      const color = Colors.purple;

      await tester.pumpApp(
        PuzzleTitle(
          title: 'Title',
          color: color,
        ),
        themeBloc: themeBloc,
      );

      final textStyle = tester.firstWidget<AnimatedDefaultTextStyle>(
        find.byType(AnimatedDefaultTextStyle),
      );

      expect(textStyle.style.color, equals(color));
    });

    testWidgets(
        'renders text '
        'using PuzzleTheme.titleColor as text color '
        'if not provided', (tester) async {
      const titleColor = Colors.green;
      when(() => theme.titleColor).thenReturn(titleColor);

      await tester.pumpApp(
        PuzzleTitle(title: 'Title'),
        themeBloc: themeBloc,
      );

      final textStyle = tester.firstWidget<AnimatedDefaultTextStyle>(
        find.byType(AnimatedDefaultTextStyle),
      );

      expect(textStyle.style.color, equals(titleColor));
    });
  });
}
