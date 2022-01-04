// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
    });

    setUpAll(() {
      registerFallbackValue(MockTile());
      registerFallbackValue(MockPuzzleEvent());
    });

    testWidgets(
        'adds TileTapped to PuzzleBloc '
        'when DashatarPuzzleStatus is started', (tester) async {
      final puzzleBloc = MockPuzzleBloc();
      final puzzleState = MockPuzzleState();
      final puzzle = MockPuzzle();

      when(puzzle.getDimension).thenReturn(4);
      when(() => puzzleState.puzzle).thenReturn(puzzle);
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
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      verify(() => puzzleBloc.add(TileTapped(tile))).called(1);
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
      );

      expect(find.byKey(Key('dashatar_puzzle_tile_large')), findsOneWidget);
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
      );

      expect(find.byKey(Key('dashatar_puzzle_tile_medium')), findsOneWidget);
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
      );

      expect(find.byKey(Key('dashatar_puzzle_tile_small')), findsOneWidget);
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
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is IconButton && widget.onPressed == null,
        ),
        findsOneWidget,
      );
    });
  });
}
