// ignore_for_file: prefer_const_constructors,
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/simple/simple.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzleKeyboardHandler', () {
    late ThemeBloc themeBloc;
    late DashatarPuzzleBloc dashatarPuzzleBloc;
    late PuzzleBloc puzzleBloc;
    late Puzzle puzzle;
    late AudioPlayer audioPlayer;
    late AudioControlBloc audioControlBloc;

    const tile = Tile(
      value: 1,
      currentPosition: Position(x: 1, y: 1),
      correctPosition: Position(x: 2, y: 2),
    );

    setUp(() {
      themeBloc = MockThemeBloc();
      when(() => themeBloc.state).thenReturn(
        ThemeState(
          themes: [SimpleTheme(), GreenDashatarTheme()],
          theme: SimpleTheme(),
        ),
      );

      dashatarPuzzleBloc = MockDashatarPuzzleBloc();
      when(() => dashatarPuzzleBloc.state).thenReturn(
        DashatarPuzzleState(secondsToBegin: 3),
      );

      puzzleBloc = MockPuzzleBloc();
      final puzzleState = MockPuzzleState();
      puzzle = MockPuzzle();
      when(() => puzzleState.puzzle).thenReturn(puzzle);
      when(() => puzzleBloc.state).thenReturn(puzzleState);

      audioPlayer = MockAudioPlayer();
      when(() => audioPlayer.setAsset(any())).thenAnswer((_) async => null);
      when(() => audioPlayer.seek(any())).thenAnswer((_) async {});
      when(() => audioPlayer.setVolume(any())).thenAnswer((_) async {});
      when(audioPlayer.play).thenAnswer((_) async {});
      when(audioPlayer.stop).thenAnswer((_) async {});
      when(audioPlayer.dispose).thenAnswer((_) async {});

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    testWidgets(
        'adds TileTapped with a tile relative to the whitespace tile '
        'with offset (0, -1) '
        'and plays the tile_move sound '
        'when arrow down is pressed', (tester) async {
      when(() => puzzle.getTileRelativeToWhitespaceTile(Offset(0, -1)))
          .thenReturn(tile);

      await tester.pumpApp(
        PuzzleKeyboardHandler(
          child: SizedBox(),
          audioPlayer: () => audioPlayer,
        ),
        themeBloc: themeBloc,
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      await simulateKeyDownEvent(
        LogicalKeyboardKey.arrowDown,
        physicalKey: PhysicalKeyboardKey.arrowDown,
      );

      verify(() => puzzle.getTileRelativeToWhitespaceTile(Offset(0, -1)))
          .called(1);

      verify(() => puzzleBloc.add(TileTapped(tile))).called(1);

      verify(() => audioPlayer.setAsset('assets/audio/tile_move.mp3'))
          .called(1);
      verify(audioPlayer.play).called(1);
    });

    testWidgets(
        'adds TileTapped with a tile relative to the whitespace tile '
        'with offset (0, 1) '
        'and plays the tile_move sound '
        'when arrow up is pressed', (tester) async {
      when(() => puzzle.getTileRelativeToWhitespaceTile(Offset(0, 1)))
          .thenReturn(tile);

      await tester.pumpApp(
        PuzzleKeyboardHandler(
          child: SizedBox(),
          audioPlayer: () => audioPlayer,
        ),
        themeBloc: themeBloc,
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      await simulateKeyDownEvent(
        LogicalKeyboardKey.arrowUp,
        physicalKey: PhysicalKeyboardKey.arrowUp,
      );

      verify(() => puzzle.getTileRelativeToWhitespaceTile(Offset(0, 1)))
          .called(1);

      verify(() => puzzleBloc.add(TileTapped(tile))).called(1);

      verify(() => audioPlayer.setAsset('assets/audio/tile_move.mp3'))
          .called(1);
      verify(audioPlayer.play).called(1);
    });

    testWidgets(
        'adds TileTapped with a tile relative to the whitespace tile '
        'with offset (-1, 0) '
        'and plays the tile_move sound '
        'when arrow right is pressed', (tester) async {
      when(() => puzzle.getTileRelativeToWhitespaceTile(Offset(-1, 0)))
          .thenReturn(tile);

      await tester.pumpApp(
        PuzzleKeyboardHandler(
          child: SizedBox(),
          audioPlayer: () => audioPlayer,
        ),
        themeBloc: themeBloc,
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      await simulateKeyDownEvent(
        LogicalKeyboardKey.arrowRight,
        physicalKey: PhysicalKeyboardKey.arrowRight,
      );

      verify(() => puzzle.getTileRelativeToWhitespaceTile(Offset(-1, 0)))
          .called(1);

      verify(() => puzzleBloc.add(TileTapped(tile))).called(1);

      verify(() => audioPlayer.setAsset('assets/audio/tile_move.mp3'))
          .called(1);
      verify(audioPlayer.play).called(1);
    });

    testWidgets(
        'adds TileTapped with a tile relative to the whitespace tile '
        'with offset (1, 0) '
        'and plays the tile_move sound '
        'when arrow left is pressed', (tester) async {
      when(() => puzzle.getTileRelativeToWhitespaceTile(Offset(1, 0)))
          .thenReturn(tile);

      await tester.pumpApp(
        PuzzleKeyboardHandler(
          child: SizedBox(),
          audioPlayer: () => audioPlayer,
        ),
        themeBloc: themeBloc,
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      await simulateKeyDownEvent(
        LogicalKeyboardKey.arrowLeft,
        physicalKey: PhysicalKeyboardKey.arrowLeft,
      );

      verify(() => puzzle.getTileRelativeToWhitespaceTile(Offset(1, 0)))
          .called(1);

      verify(() => puzzleBloc.add(TileTapped(tile))).called(1);

      verify(() => audioPlayer.setAsset('assets/audio/tile_move.mp3'))
          .called(1);
      verify(audioPlayer.play).called(1);
    });

    testWidgets(
        'does not add TileTapped '
        'when arrow is pressed and '
        'Dashatar puzzle is not started', (tester) async {
      when(() => themeBloc.state).thenReturn(
        ThemeState(
          themes: [SimpleTheme(), GreenDashatarTheme()],
          theme: GreenDashatarTheme(),
        ),
      );

      await tester.pumpApp(
        PuzzleKeyboardHandler(child: SizedBox()),
        themeBloc: themeBloc,
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      await simulateKeyDownEvent(
        LogicalKeyboardKey.arrowLeft,
        physicalKey: PhysicalKeyboardKey.arrowLeft,
      );

      verifyNever(() => puzzle.getTileRelativeToWhitespaceTile(Offset(1, 0)));
      verifyNever(() => puzzleBloc.add(TileTapped(tile)));
    });

    testWidgets('renders child', (tester) async {
      const key = Key('__child__');

      await tester.pumpApp(
        PuzzleKeyboardHandler(
          child: SizedBox(key: key),
        ),
        themeBloc: themeBloc,
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('renders AudioControlListener', (tester) async {
      await tester.pumpApp(
        PuzzleKeyboardHandler(
          child: SizedBox(),
        ),
        themeBloc: themeBloc,
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(AudioControlListener), findsOneWidget);
    });
  });
}
