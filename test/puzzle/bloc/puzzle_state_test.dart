// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

void main() {
  final position = Position(x: 1, y: 1);
  final tile = Tile(
    value: 0,
    correctPosition: position,
    currentPosition: position,
  );
  final puzzle = Puzzle(tiles: [tile]);
  const tileMovementStatus = TileMovementStatus.nothingTapped;

  group('PuzzleState', () {
    group('PuzzleInitial', () {
      test('supports value comparisons', () {
        expect(PuzzleInitial(), PuzzleInitial());
      });
    });

    group('PuzzlePlayable', () {
      test('supports value comparisons', () {
        expect(
            PuzzlePlayable(
              puzzle: puzzle,
              tileMovementStatus: tileMovementStatus,
              numberOfCorrectTiles: 0,
              numberOfMoves: 0,
            ),
            PuzzlePlayable(
              puzzle: puzzle,
              tileMovementStatus: tileMovementStatus,
              numberOfCorrectTiles: 0,
              numberOfMoves: 0,
            ));
      });
    });

    group('PuzzleComplete', () {
      test('supports value comparisons', () {
        expect(
            PuzzleComplete(
              puzzle: puzzle,
              tileMovementStatus: tileMovementStatus,
              numberOfCorrectTiles: 0,
              numberOfMoves: 0,
            ),
            PuzzleComplete(
              puzzle: puzzle,
              tileMovementStatus: tileMovementStatus,
              numberOfCorrectTiles: 0,
              numberOfMoves: 0,
            ));
      });
    });
  });
}
