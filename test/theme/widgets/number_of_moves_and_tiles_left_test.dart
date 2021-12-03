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
      final themeState = MockThemeState();

      when(() => theme.defaultColor).thenReturn(Colors.black);
      when(() => themeState.theme).thenReturn(theme);
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
        find.byKey(Key('numberOfMovesAndTilesLeft')),
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
        find.byKey(Key('numberOfMovesAndTilesLeft')),
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
        find.byKey(Key('numberOfMovesAndTilesLeft')),
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
        find.text('5 Moves | 15 Tiles', findRichText: true),
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

      final rootText = tester.widget<RichText>(find.byType(RichText));

      expect(
        rootText.text.style?.color,
        equals(color),
      );
    });

    testWidgets(
        'renders text using defaultColor from theme '
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

      final rootText = tester.widget<RichText>(find.byType(RichText));

      expect(
        rootText.text.style?.color,
        equals(themeColor),
      );
    });
  });
}
