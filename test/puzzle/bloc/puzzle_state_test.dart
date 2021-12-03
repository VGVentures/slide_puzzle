// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

import '../../helpers/helpers.dart';

void main() {
  final position = Position(x: 1, y: 1);
  final tile = Tile(
    value: 0,
    correctPosition: position,
    currentPosition: position,
  );
  final puzzle = Puzzle(tiles: [tile]);

  group('PuzzleState', () {
    test('supports value comparisons', () {
      expect(PuzzleState(), equals(PuzzleState()));
    });

    test('numberOfTilesLeft returns a correct value', () {
      final tiles = [MockTile(), MockTile(), MockTile()];
      const numberOfCorrectTiles = 1;

      expect(
        PuzzleState(
          puzzle: Puzzle(tiles: tiles),
          numberOfCorrectTiles: numberOfCorrectTiles,
        ).numberOfTilesLeft,
        equals(tiles.length - numberOfCorrectTiles - 1),
      );
    });

    group('copyWith', () {
      test('returns same object when no properties are passed', () {
        expect(PuzzleState().copyWith(), equals(PuzzleState()));
      });

      test('returns object with updated puzzle when puzzle is passed', () {
        expect(
          PuzzleState().copyWith(puzzle: puzzle),
          equals(PuzzleState(puzzle: puzzle)),
        );
      });

      test(
          'returns object with updated puzzle status when puzzle status is '
          'passed', () {
        expect(
          PuzzleState().copyWith(puzzleStatus: PuzzleStatus.complete),
          equals(PuzzleState(puzzleStatus: PuzzleStatus.complete)),
        );
      });

      test(
          'returns object with updated tile movement status when tile movement '
          'status is passed', () {
        expect(
          PuzzleState().copyWith(tileMovementStatus: TileMovementStatus.moved),
          equals(PuzzleState(tileMovementStatus: TileMovementStatus.moved)),
        );
      });

      test(
          'returns object with updated number of correct tiles when number of '
          'correct tiles is passed', () {
        expect(
          PuzzleState().copyWith(numberOfCorrectTiles: 1),
          equals(PuzzleState(numberOfCorrectTiles: 1)),
        );
      });

      test(
          'returns object with updated number of moves when number of moves is '
          'passed', () {
        expect(
          PuzzleState().copyWith(numberOfMoves: 1),
          equals(PuzzleState(numberOfMoves: 1)),
        );
      });
    });
  });
}
