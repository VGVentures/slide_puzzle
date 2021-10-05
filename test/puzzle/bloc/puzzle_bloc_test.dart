// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

void main() {
  group('PuzzleBloc', () {
    test('initial state is PuzzleState', () {
      expect(
        PuzzleBloc(4).state,
        PuzzleState(),
      );
    });

    group('Initialize', () {
      final tile1 = Tile(
        value: 0,
        correctPosition: Position(x: 1, y: 1),
        currentPosition: Position(x: 1, y: 1),
      );
      final puzzleSize1 = Puzzle(tiles: [tile1]);

      blocTest<PuzzleBloc, PuzzleState>(
        'emits 1 tile when initialized with size 1',
        build: () => PuzzleBloc(1),
        act: (bloc) => bloc.add(PuzzleInitialized()),
        expect: () => <PuzzleState>[PuzzleState(puzzle: puzzleSize1)],
      );
    });

    group('TileTapped', () {
      const size = 3;
      final topLeft = Position(x: 1, y: 1);
      final topCenter = Position(x: 2, y: 1);
      final topRight = Position(x: 3, y: 1);
      final middleLeft = Position(x: 1, y: 2);
      final middleCenter = Position(x: 2, y: 2);
      final middleRight = Position(x: 3, y: 2);
      final bottomLeft = Position(x: 1, y: 3);
      final bottomCenter = Position(x: 2, y: 3);
      final bottomRight = Position(x: 3, y: 3);

      final topLeftTile = Tile(
        value: 2,
        correctPosition: topCenter,
        currentPosition: topLeft,
      );
      final topCenterTile = Tile(
        value: 1,
        correctPosition: topLeft,
        currentPosition: topCenter,
      );
      final topRightTile = Tile(
        value: 3,
        correctPosition: topRight,
        currentPosition: topRight,
      );
      final middleLeftTile = Tile(
        value: 4,
        correctPosition: middleLeft,
        currentPosition: middleLeft,
      );
      final middleCenterTile = Tile(
        value: 5,
        correctPosition: middleCenter,
        currentPosition: middleCenter,
      );
      final middleRightTile = Tile(
        value: 6,
        correctPosition: middleRight,
        currentPosition: middleRight,
      );
      final bottomLeftTile = Tile(
        value: 7,
        correctPosition: bottomLeft,
        currentPosition: bottomLeft,
      );
      final bottomCenterTile = Tile(
        value: 8,
        correctPosition: bottomCenter,
        currentPosition: bottomCenter,
      );
      final whitespaceTile = Tile(
        value: 0,
        correctPosition: bottomRight,
        currentPosition: bottomRight,
      );
      final tiles = [
        topLeftTile,
        topCenterTile,
        topRightTile,
        middleLeftTile,
        middleCenterTile,
        middleRightTile,
        bottomLeftTile,
        bottomCenterTile,
        whitespaceTile,
      ];
      final puzzle = Puzzle(tiles: tiles);

      blocTest<PuzzleBloc, PuzzleState>(
        'emits [moved] when one tile was able to move',
        build: () => PuzzleBloc(size),
        seed: () => PuzzleState(puzzle: puzzle),
        act: (bloc) => bloc.add(TileTapped(middleRightTile)),
        expect: () => <PuzzleState>[
          PuzzleState(
            puzzle: Puzzle(
              tiles: [
                topLeftTile,
                topCenterTile,
                topRightTile,
                middleLeftTile,
                middleCenterTile,
                Tile(
                  value: 6,
                  correctPosition: middleRight,
                  currentPosition: bottomRight,
                ),
                bottomLeftTile,
                bottomCenterTile,
                Tile(
                  value: 0,
                  correctPosition: bottomRight,
                  currentPosition: middleRight,
                ),
              ],
            ),
            tileMovementStatus: TileMovementStatus.moved,
          ),
        ],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits [moved] when mutiple tiles were able to move',
        build: () => PuzzleBloc(size),
        seed: () => PuzzleState(puzzle: puzzle),
        act: (bloc) => bloc.add(TileTapped(topRightTile)),
        expect: () => <PuzzleState>[
          PuzzleState(
            puzzle: Puzzle(
              tiles: [
                topLeftTile,
                topCenterTile,
                Tile(
                  value: 3,
                  correctPosition: topRight,
                  currentPosition: middleRight,
                ),
                middleLeftTile,
                middleCenterTile,
                Tile(
                  value: 6,
                  correctPosition: middleRight,
                  currentPosition: bottomRight,
                ),
                bottomLeftTile,
                bottomCenterTile,
                Tile(
                  value: 0,
                  correctPosition: bottomRight,
                  currentPosition: topRight,
                ),
              ],
            ),
            tileMovementStatus: TileMovementStatus.moved,
          ),
        ],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits [cannotBeMoved] when tapped tile cannot move to whitespace',
        build: () => PuzzleBloc(size),
        seed: () => PuzzleState(puzzle: puzzle),
        act: (bloc) => bloc.add(TileTapped(topLeftTile)),
        expect: () => [
          isA<PuzzleState>().having(
            (state) => state.tileMovementStatus,
            'tileMovementStatus',
            TileMovementStatus.cannotBeMoved,
          ),
        ],
      );
    });
  });
}
