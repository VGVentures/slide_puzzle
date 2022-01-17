// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarPuzzleTile', () {
    late DashatarPuzzleBloc dashatarPuzzleBloc;
    late DashatarPuzzleState dashatarPuzzleState;
    late DashatarThemeBloc dashatarThemeBloc;
    late DashatarTheme dashatarTheme;
    late AudioControlBloc audioControlBloc;
    late PuzzleBloc puzzleBloc;
    late PuzzleState puzzleState;
    late Tile tile;

    setUp(() {
      dashatarPuzzleBloc = MockDashatarPuzzleBloc();
      dashatarPuzzleState = MockDashatarPuzzleState();

      when(() => dashatarPuzzleState.status)
          .thenReturn(DashatarPuzzleStatus.notStarted);

      whenListen(
        dashatarPuzzleBloc,
        Stream.value(dashatarPuzzleState),
        initialState: dashatarPuzzleState,
      );

      dashatarThemeBloc = MockDashatarThemeBloc();
      dashatarTheme = GreenDashatarTheme();
      final dashatarThemeState = DashatarThemeState(
        themes: [dashatarTheme],
        theme: dashatarTheme,
      );

      when(() => dashatarThemeBloc.state).thenReturn(dashatarThemeState);

      tile = Tile(
        correctPosition: Position(x: 1, y: 1),
        currentPosition: Position(x: 1, y: 1),
        value: 1,
      );

      puzzleBloc = MockPuzzleBloc();
      puzzleState = MockPuzzleState();

      when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.incomplete);
      whenListen(
        puzzleBloc,
        Stream.value(puzzleState),
        initialState: puzzleState,
      );

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    setUpAll(() {
      registerFallbackValue(MockTile());
      registerFallbackValue(MockPuzzleEvent());
    });

    testWidgets(
        'adds TileTapped to PuzzleBloc '
        'and plays the tile_move sound '
        'when tapped and '
        'DashatarPuzzleStatus is started and '
        'PuzzleStatus is incomplete', (tester) async {
      final audioPlayer = MockAudioPlayer();
      when(() => audioPlayer.setAsset(any())).thenAnswer((_) async => null);
      when(() => audioPlayer.seek(any())).thenAnswer((_) async {});
      when(() => audioPlayer.setVolume(any())).thenAnswer((_) async {});
      when(audioPlayer.play).thenAnswer((_) async {});
      when(audioPlayer.stop).thenAnswer((_) async {});
      when(audioPlayer.dispose).thenAnswer((_) async {});

      final puzzle = MockPuzzle();

      when(puzzle.getDimension).thenReturn(4);
      when(() => puzzleState.puzzle).thenReturn(puzzle);
      when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.incomplete);
      when(() => dashatarPuzzleState.status)
          .thenReturn(DashatarPuzzleStatus.started);

      await tester.pumpApp(
        Scaffold(
          body: DashatarPuzzleTile(
            state: puzzleState,
            tile: tile,
            audioPlayer: () => audioPlayer,
          ),
        ),
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      // Wait for the initialization of the audio player.
      await tester.pump(Duration(seconds: 1));

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      verify(() => puzzleBloc.add(TileTapped(tile))).called(1);
      verify(() => audioPlayer.setAsset('assets/audio/tile_move.mp3'))
          .called(1);
      verify(audioPlayer.play).called(1);
    });

    testWidgets(
        'does not add TileTapped to PuzzleBloc '
        'when tapped and DashatarPuzzleStatus is notStarted', (tester) async {
      final puzzle = MockPuzzle();

      when(puzzle.getDimension).thenReturn(4);
      when(() => puzzleState.puzzle).thenReturn(puzzle);
      when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.incomplete);
      when(() => dashatarPuzzleState.status)
          .thenReturn(DashatarPuzzleStatus.notStarted);

      await tester.pumpApp(
        Scaffold(
          body: DashatarPuzzleTile(
            state: puzzleState,
            tile: tile,
          ),
        ),
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      verifyNever(() => puzzleBloc.add(TileTapped(tile)));
    });

    testWidgets(
        'does not add TileTapped to PuzzleBloc '
        'when tapped and PuzzleStatus is complete', (tester) async {
      final puzzle = MockPuzzle();

      when(puzzle.getDimension).thenReturn(4);
      when(() => puzzleState.puzzle).thenReturn(puzzle);
      when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.complete);
      when(() => dashatarPuzzleState.status)
          .thenReturn(DashatarPuzzleStatus.started);

      await tester.pumpApp(
        Scaffold(
          body: DashatarPuzzleTile(
            state: puzzleState,
            tile: tile,
          ),
        ),
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      verifyNever(() => puzzleBloc.add(TileTapped(tile)));
    });

    testWidgets('renders a large tile on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        Scaffold(
          body: DashatarPuzzleTile(
            state: PuzzleState(),
            tile: tile,
          ),
        ),
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('dashatar_puzzle_tile_large_${tile.value}')),
        findsOneWidget,
      );
    });

    testWidgets('renders a medium tile on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        Scaffold(
          body: DashatarPuzzleTile(
            state: PuzzleState(),
            tile: tile,
          ),
        ),
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('dashatar_puzzle_tile_medium_${tile.value}')),
        findsOneWidget,
      );
    });

    testWidgets('renders a small tile on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        Scaffold(
          body: DashatarPuzzleTile(
            state: PuzzleState(),
            tile: tile,
          ),
        ),
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('dashatar_puzzle_tile_small_${tile.value}')),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders IconButton '
        'with Dashatar icon', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: DashatarPuzzleTile(
            state: PuzzleState(),
            tile: tile,
          ),
        ),
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              (widget.image as AssetImage).assetName ==
                  dashatarTheme.dashAssetForTile(tile),
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders disabled IconButton '
        'when DashatarPuzzleStatus is loading', (tester) async {
      when(() => dashatarPuzzleState.status)
          .thenReturn(DashatarPuzzleStatus.loading);

      await tester.pumpApp(
        Scaffold(
          body: DashatarPuzzleTile(
            state: PuzzleState(),
            tile: tile,
          ),
        ),
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is IconButton && widget.onPressed == null,
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders AudioControlListener', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: DashatarPuzzleTile(
            state: PuzzleState(),
            tile: tile,
          ),
        ),
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(AudioControlListener), findsOneWidget);
    });

    testWidgets(
        'scales IconButton '
        'when hovered over', (tester) async {
      when(() => dashatarPuzzleState.status)
          .thenReturn(DashatarPuzzleStatus.started);

      await tester.pumpApp(
        Scaffold(
          body: Column(
            children: [
              DashatarPuzzleTile(
                state: PuzzleState(),
                tile: tile,
              ),
              const SizedBox(
                key: Key('__sized_box__'),
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
        dashatarPuzzleBloc: dashatarPuzzleBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        puzzleBloc: puzzleBloc,
        audioControlBloc: audioControlBloc,
      );

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await gesture.moveTo(tester.getCenter(find.byType(IconButton)));
      await tester.pumpAndSettle();

      final scaleWithHover = tester
          .widget<ScaleTransition>(
            find.byKey(Key('dashatar_puzzle_tile_scale_${tile.value}')),
          )
          .scale
          .value;

      await gesture.moveTo(tester.getCenter(find.byKey(Key('__sized_box__'))));
      await tester.pumpAndSettle();

      final scaleWithoutHover = tester
          .widget<ScaleTransition>(
            find.byKey(Key('dashatar_puzzle_tile_scale_${tile.value}')),
          )
          .scale
          .value;

      expect(scaleWithHover, lessThan(scaleWithoutHover));
    });
  });
}
