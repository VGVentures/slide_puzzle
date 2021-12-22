// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzlePage', () {
    testWidgets('renders PuzzleView', (tester) async {
      await tester.pumpApp(PuzzlePage());
      expect(find.byType(PuzzleView), findsOneWidget);
    });
  });

  group('PuzzleView', () {
    late ThemeBloc themeBloc;
    late PuzzleTheme theme;
    late PuzzleLayoutDelegate layoutDelegate;

    setUp(() {
      final themeState = MockThemeState();
      themeBloc = MockThemeBloc();
      theme = MockPuzzleTheme();
      layoutDelegate = MockPuzzleLayoutDelegate();

      when(() => layoutDelegate.startSectionBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.endSectionBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.backgroundBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.boardBuilder(any(), any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.tileBuilder(any(), any()))
          .thenReturn(SizedBox());

      when(layoutDelegate.whitespaceTileBuilder).thenReturn(SizedBox());

      when(() => theme.layoutDelegate).thenReturn(layoutDelegate);
      when(() => theme.backgroundColor).thenReturn(Colors.black);
      when(() => theme.hasTimer).thenReturn(true);
      when(() => themeState.theme).thenReturn(theme);
      when(() => themeBloc.state).thenReturn(themeState);
    });

    setUpAll(() {
      registerFallbackValue(MockPuzzleState());
      registerFallbackValue(MockTile());
    });

    testWidgets(
        'renders Scaffold '
        'with background color from theme', (tester) async {
      const backgroundColor = Colors.orange;
      when(() => theme.backgroundColor).thenReturn(backgroundColor);

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Scaffold && widget.backgroundColor == backgroundColor,
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders puzzle correctly '
        'on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      expect(find.byKey(Key('puzzle_view_puzzle')), findsOneWidget);
    });

    testWidgets(
        'renders puzzle correctly '
        'on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      expect(find.byKey(Key('puzzle_view_puzzle')), findsOneWidget);
    });

    testWidgets(
        'renders puzzle correctly '
        'on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      expect(find.byKey(Key('puzzle_view_puzzle')), findsOneWidget);
    });

    testWidgets('renders puzzle header', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      expect(find.byKey(Key('puzzle_header')), findsOneWidget);
    });

    testWidgets('renders puzzle sections', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      expect(find.byKey(Key('puzzle_sections')), findsOneWidget);
    });

    testWidgets(
        'builds start section '
        'with layoutDelegate.startSectionBuilder', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      verify(() => layoutDelegate.startSectionBuilder(any())).called(1);
    });

    testWidgets(
        'builds end section '
        'with layoutDelegate.endSectionBuilder', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
    });

    testWidgets(
        'builds background '
        'with layoutDelegate.backgroundBuilder', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      verify(() => layoutDelegate.backgroundBuilder(any())).called(1);
    });

    testWidgets(
        'builds board '
        'with layoutDelegate.boardBuilder', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      await tester.pumpAndSettle();

      verify(() => layoutDelegate.boardBuilder(any(), any())).called(1);
    });

    testWidgets(
        'builds 15 tiles '
        'with layoutDelegate.tileBuilder', (tester) async {
      when(() => layoutDelegate.boardBuilder(any(), any()))
          .thenAnswer((invocation) {
        final tiles = invocation.positionalArguments[1] as List<Widget>;
        return Row(children: tiles);
      });

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      await tester.pumpAndSettle();

      verify(() => layoutDelegate.tileBuilder(any(), any())).called(15);
    });

    testWidgets(
        'builds 1 whitespace tile '
        'with layoutDelegate.whitespaceTileBuilder', (tester) async {
      when(() => layoutDelegate.boardBuilder(any(), any()))
          .thenAnswer((invocation) {
        final tiles = invocation.positionalArguments[1] as List<Widget>;
        return Row(children: tiles);
      });

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      await tester.pumpAndSettle();

      verify(layoutDelegate.whitespaceTileBuilder).called(1);
    });

    testWidgets(
        'may start a timer '
        'in layoutDelegate', (tester) async {
      when(() => layoutDelegate.startSectionBuilder(any()))
          .thenAnswer((invocation) {
        return Builder(
          builder: (context) {
            return TextButton(
              onPressed: () => context.read<TimerBloc>().add(TimerStarted()),
              key: Key('__start_timer__'),
              child: Text('Start timer'),
            );
          },
        );
      });

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('__start_timer__')));
    });

    group('PuzzleBoard', () {
      testWidgets(
          'adds TimerStopped to TimerBloc '
          'when the puzzle completes', (tester) async {
        final timerBloc = MockTimerBloc();
        final timerState = MockTimerState();
        final puzzleBloc = MockPuzzleBloc();
        final puzzleState = MockPuzzleState();
        final puzzle = MockPuzzle();

        when(puzzle.getDimension).thenReturn(4);
        when(() => puzzle.tiles).thenReturn([]);
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.complete);
        whenListen(
          puzzleBloc,
          Stream.value(puzzleState),
          initialState: puzzleState,
        );

        const secondsElapsed = 60;
        when(() => timerState.secondsElapsed).thenReturn(secondsElapsed);
        when(() => timerBloc.state).thenReturn(timerState);

        await tester.pumpApp(
          PuzzleBoard(),
          themeBloc: themeBloc,
          timerBloc: timerBloc,
          puzzleBloc: puzzleBloc,
        );

        verify(() => timerBloc.add(TimerStopped())).called(1);
      });
    });
  });
}
