// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarScore', () {
    late DashatarThemeBloc dashatarThemeBloc;
    late PuzzleBloc puzzleBloc;
    late TimerBloc timerBloc;

    setUp(() {
      dashatarThemeBloc = MockDashatarThemeBloc();
      when(() => dashatarThemeBloc.state).thenReturn(
        DashatarThemeState(themes: [GreenDashatarTheme()]),
      );

      puzzleBloc = MockPuzzleBloc();
      when(() => puzzleBloc.state).thenReturn(PuzzleState());

      timerBloc = MockTimerBloc();
      when(() => timerBloc.state).thenReturn(TimerState());
    });

    testWidgets('renders on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        SingleChildScrollView(
          child: DashatarScore(),
        ),
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(
        find.byKey(Key('dashatar_score')),
        findsOneWidget,
      );
    });

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        SingleChildScrollView(
          child: DashatarScore(),
        ),
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(
        find.byKey(Key('dashatar_score')),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        SingleChildScrollView(
          child: DashatarScore(),
        ),
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(
        find.byKey(Key('dashatar_score')),
        findsOneWidget,
      );
    });

    testWidgets('renders successThemeAsset from DashatarTheme', (tester) async {
      const theme = BlueDashatarTheme();

      when(() => dashatarThemeBloc.state).thenReturn(
        DashatarThemeState(
          themes: [GreenDashatarTheme(), theme],
          theme: theme,
        ),
      );

      await tester.pumpApp(
        SingleChildScrollView(
          child: DashatarScore(),
        ),
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              (widget.image as AssetImage).assetName == theme.successThemeAsset,
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders AppFlutterLogo', (tester) async {
      await tester.pumpApp(
        SingleChildScrollView(
          child: DashatarScore(),
        ),
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(
        find.byType(AppFlutterLogo),
        findsOneWidget,
      );
    });

    testWidgets('renders completed text', (tester) async {
      await tester.pumpApp(
        SingleChildScrollView(
          child: DashatarScore(),
        ),
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(
        find.byKey(Key('dashatar_score_completed')),
        findsOneWidget,
      );
    });

    testWidgets('renders well done text', (tester) async {
      await tester.pumpApp(
        SingleChildScrollView(
          child: DashatarScore(),
        ),
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(
        find.byKey(Key('dashatar_score_well_done')),
        findsOneWidget,
      );
    });

    testWidgets('renders score text', (tester) async {
      await tester.pumpApp(
        SingleChildScrollView(
          child: DashatarScore(),
        ),
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(
        find.byKey(Key('dashatar_score_score')),
        findsOneWidget,
      );
    });

    testWidgets('renders DashatarTimer', (tester) async {
      await tester.pumpApp(
        SingleChildScrollView(
          child: DashatarScore(),
        ),
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(
        find.byType(DashatarTimer),
        findsOneWidget,
      );
    });

    testWidgets('renders number of moves text', (tester) async {
      const numberOfMoves = 14;
      when(() => puzzleBloc.state).thenReturn(
        PuzzleState(
          numberOfMoves: numberOfMoves,
        ),
      );

      await tester.pumpApp(
        SingleChildScrollView(
          child: DashatarScore(),
        ),
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(
        find.byKey(Key('dashatar_score_number_of_moves')),
        findsOneWidget,
      );

      expect(
        find.textContaining(numberOfMoves.toString()),
        findsOneWidget,
      );
    });
  });
}
