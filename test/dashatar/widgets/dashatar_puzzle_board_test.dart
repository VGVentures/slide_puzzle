// ignore_for_file: prefer_const_constructors,
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarPuzzleBoard', () {
    late PuzzleBloc puzzleBloc;
    late PuzzleState puzzleState;

    setUp(() {
      puzzleBloc = MockPuzzleBloc();
      puzzleState = MockPuzzleState();

      when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.incomplete);
      whenListen(
        puzzleBloc,
        Stream.value(puzzleState),
        initialState: puzzleState,
      );
    });

    testWidgets(
        'shows DashatarShareDialog '
        'when PuzzleStatus is complete', (tester) async {
      final dashatarThemeBloc =
          DashatarThemeBloc(themes: [GreenDashatarTheme()]);
      final timerBloc = MockTimerBloc();
      when(() => timerBloc.state).thenReturn(TimerState());
      final controller = StreamController<PuzzleState>()..add(PuzzleState());

      final audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());

      whenListen(
        puzzleBloc,
        controller.stream,
      );

      await tester.pumpApp(
        DashatarPuzzleBoard(tiles: []),
        puzzleBloc: puzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        timerBloc: timerBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(DashatarShareDialog), findsNothing);

      controller.add(PuzzleState(puzzleStatus: PuzzleStatus.complete));

      // Wait for the dialog to appear.
      await tester.pump(const Duration(milliseconds: 370));

      // Wait for the dialog to animate.
      await tester.pump(const Duration(milliseconds: 140));

      expect(find.byType(DashatarShareDialog), findsOneWidget);
    });

    testWidgets('renders Stack with tiles', (tester) async {
      final tiles = [
        SizedBox(key: Key('__sized_box_1__')),
        SizedBox(key: Key('__sized_box_2__')),
      ];

      await tester.pumpApp(
        DashatarPuzzleBoard(tiles: tiles),
        puzzleBloc: puzzleBloc,
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Stack && widget.children == tiles,
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders a large board on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        DashatarPuzzleBoard(tiles: []),
        puzzleBloc: puzzleBloc,
      );

      expect(find.byKey(Key('dashatar_puzzle_board_large')), findsOneWidget);
    });

    testWidgets('renders a medium board on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        DashatarPuzzleBoard(tiles: []),
        puzzleBloc: puzzleBloc,
      );

      expect(find.byKey(Key('dashatar_puzzle_board_medium')), findsOneWidget);
    });

    testWidgets('renders a small board on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        DashatarPuzzleBoard(tiles: []),
        puzzleBloc: puzzleBloc,
      );

      expect(find.byKey(Key('dashatar_puzzle_board_small')), findsOneWidget);
    });
  });
}
