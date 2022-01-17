// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('NumberOfMovesAndTilesLeft', () {
    late ThemeBloc themeBloc;
    late PuzzleTheme theme;

    setUp(() {
      themeBloc = MockThemeBloc();
      theme = MockPuzzleTheme();
      final themeState = ThemeState(themes: [theme], theme: theme);

      when(() => theme.defaultColor).thenReturn(Colors.black);
      when(() => themeBloc.state).thenReturn(themeState);
    });

    testWidgets('renders on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        NumberOfMovesAndTilesLeft(
          numberOfMoves: 5,
          numberOfTilesLeft: 15,
        ),
        themeBloc: themeBloc,
      );

      expect(
        find.byKey(Key('number_of_moves_and_tiles_left')),
        findsOneWidget,
      );
    });

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        NumberOfMovesAndTilesLeft(
          numberOfMoves: 5,
          numberOfTilesLeft: 15,
        ),
        themeBloc: themeBloc,
      );

      expect(
        find.byKey(Key('number_of_moves_and_tiles_left')),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        NumberOfMovesAndTilesLeft(
          numberOfMoves: 5,
          numberOfTilesLeft: 15,
        ),
        themeBloc: themeBloc,
      );

      expect(
        find.byKey(Key('number_of_moves_and_tiles_left')),
        findsOneWidget,
      );
    });

    testWidgets('renders the number of moves and tiles left', (tester) async {
      await tester.pumpApp(
        NumberOfMovesAndTilesLeft(
          numberOfMoves: 5,
          numberOfTilesLeft: 15,
        ),
        themeBloc: themeBloc,
      );

      expect(
        find.descendant(
          of: find.byKey(Key('number_of_moves_and_tiles_left_moves')),
          matching: find.text('5'),
        ),
        findsOneWidget,
      );

      expect(
        find.descendant(
          of: find.byKey(Key('number_of_moves_and_tiles_left_tiles_left')),
          matching: find.text('15'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders text in the given color', (tester) async {
      const color = Colors.purple;

      await tester.pumpApp(
        NumberOfMovesAndTilesLeft(
          numberOfMoves: 5,
          numberOfTilesLeft: 15,
          color: color,
        ),
        themeBloc: themeBloc,
      );

      final textStyles = tester.widgetList<AnimatedDefaultTextStyle>(
        find.byType(AnimatedDefaultTextStyle),
      );

      for (final textStyle in textStyles) {
        expect(textStyle.style.color, equals(color));
      }
    });

    testWidgets(
        'renders text '
        'using PuzzleTheme.defaultColor as text color '
        'if not provided', (tester) async {
      const themeColor = Colors.green;

      when(() => theme.defaultColor).thenReturn(themeColor);

      await tester.pumpApp(
        NumberOfMovesAndTilesLeft(
          numberOfMoves: 5,
          numberOfTilesLeft: 15,
        ),
        themeBloc: themeBloc,
      );

      final textStyles = tester.widgetList<AnimatedDefaultTextStyle>(
        find.byType(AnimatedDefaultTextStyle),
      );

      for (final textStyle in textStyles) {
        expect(textStyle.style.color, equals(themeColor));
      }
    });
  });
}
