import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

void main() {
  const unsolvableOddPuzzle = Puzzle(tiles: [
    Tile(
      value: 1,
      correctPosition: Position(x: 1, y: 1),
      currentPosition: Position(x: 2, y: 1),
    ),
    Tile(
      value: 2,
      correctPosition: Position(x: 2, y: 1),
      currentPosition: Position(x: 1, y: 1),
    ),
    Tile(
      value: 3,
      correctPosition: Position(x: 3, y: 1),
      currentPosition: Position(x: 3, y: 1),
    ),
    Tile(
      value: 4,
      correctPosition: Position(x: 1, y: 2),
      currentPosition: Position(x: 1, y: 2),
    ),
    Tile(
      value: 5,
      correctPosition: Position(x: 2, y: 2),
      currentPosition: Position(x: 2, y: 2),
    ),
    Tile(
      value: 6,
      correctPosition: Position(x: 3, y: 2),
      currentPosition: Position(x: 3, y: 2),
    ),
    Tile(
      value: 7,
      correctPosition: Position(x: 1, y: 3),
      currentPosition: Position(x: 1, y: 3),
    ),
    Tile(
      value: 8,
      correctPosition: Position(x: 2, y: 3),
      currentPosition: Position(x: 2, y: 3),
    ),
    Tile(
      value: 0,
      correctPosition: Position(x: 3, y: 3),
      currentPosition: Position(x: 3, y: 3),
    ),
  ]);

  const solvableOddPuzzle = Puzzle(tiles: [
    Tile(
      value: 1,
      correctPosition: Position(x: 1, y: 1),
      currentPosition: Position(x: 1, y: 1),
    ),
    Tile(
      value: 2,
      correctPosition: Position(x: 2, y: 1),
      currentPosition: Position(x: 3, y: 2),
    ),
    Tile(
      value: 3,
      correctPosition: Position(x: 3, y: 1),
      currentPosition: Position(x: 2, y: 1),
    ),
    Tile(
      value: 4,
      correctPosition: Position(x: 1, y: 2),
      currentPosition: Position(x: 3, y: 1),
    ),
    Tile(
      value: 5,
      correctPosition: Position(x: 2, y: 2),
      currentPosition: Position(x: 1, y: 3),
    ),
    Tile(
      value: 6,
      correctPosition: Position(x: 3, y: 2),
      currentPosition: Position(x: 3, y: 3),
    ),
    Tile(
      value: 7,
      correctPosition: Position(x: 1, y: 3),
      currentPosition: Position(x: 1, y: 2),
    ),
    Tile(
      value: 8,
      correctPosition: Position(x: 2, y: 3),
      currentPosition: Position(x: 2, y: 3),
    ),
    Tile(
      value: 0,
      correctPosition: Position(x: 3, y: 3),
      currentPosition: Position(x: 2, y: 2),
    ),
  ]);

  const unsolvableEvenPuzzle = Puzzle(tiles: [
    Tile(
      value: 1,
      correctPosition: Position(x: 1, y: 1),
      currentPosition: Position(x: 1, y: 1),
    ),
    Tile(
      value: 2,
      correctPosition: Position(x: 2, y: 1),
      currentPosition: Position(x: 2, y: 1),
    ),
    Tile(
      value: 3,
      correctPosition: Position(x: 3, y: 1),
      currentPosition: Position(x: 3, y: 1),
    ),
    Tile(
      value: 4,
      correctPosition: Position(x: 4, y: 1),
      currentPosition: Position(x: 4, y: 1),
    ),
    Tile(
      value: 5,
      correctPosition: Position(x: 1, y: 2),
      currentPosition: Position(x: 1, y: 2),
    ),
    Tile(
      value: 6,
      correctPosition: Position(x: 2, y: 2),
      currentPosition: Position(x: 2, y: 2),
    ),
    Tile(
      value: 7,
      correctPosition: Position(x: 3, y: 2),
      currentPosition: Position(x: 3, y: 2),
    ),
    Tile(
      value: 8,
      correctPosition: Position(x: 4, y: 2),
      currentPosition: Position(x: 4, y: 2),
    ),
    Tile(
      value: 9,
      correctPosition: Position(x: 1, y: 3),
      currentPosition: Position(x: 1, y: 3),
    ),
    Tile(
      value: 10,
      correctPosition: Position(x: 2, y: 3),
      currentPosition: Position(x: 2, y: 3),
    ),
    Tile(
      value: 11,
      correctPosition: Position(x: 3, y: 3),
      currentPosition: Position(x: 3, y: 3),
    ),
    Tile(
      value: 12,
      correctPosition: Position(x: 4, y: 3),
      currentPosition: Position(x: 4, y: 3),
    ),
    Tile(
      value: 13,
      correctPosition: Position(x: 1, y: 4),
      currentPosition: Position(x: 1, y: 4),
    ),
    Tile(
      value: 14,
      correctPosition: Position(x: 2, y: 4),
      currentPosition: Position(x: 3, y: 4),
    ),
    Tile(
      value: 15,
      correctPosition: Position(x: 3, y: 4),
      currentPosition: Position(x: 2, y: 4),
    ),
    Tile(
      value: 0,
      correctPosition: Position(x: 4, y: 4),
      currentPosition: Position(x: 4, y: 4),
    ),
  ]);

  const solvableEvenPuzzle = Puzzle(tiles: [
    Tile(
      value: 1,
      correctPosition: Position(x: 1, y: 1),
      currentPosition: Position(x: 2, y: 1),
    ),
    Tile(
      value: 2,
      correctPosition: Position(x: 2, y: 1),
      currentPosition: Position(x: 2, y: 2),
    ),
    Tile(
      value: 3,
      correctPosition: Position(x: 1, y: 2),
      currentPosition: Position(x: 1, y: 2),
    ),
    Tile(
      value: 0,
      correctPosition: Position(x: 2, y: 2),
      currentPosition: Position(x: 1, y: 1),
    ),
  ]);

  group('Puzzle', () {
    group('getPuzzleDimension', () {
      const tile = Tile(
        value: 1,
        correctPosition: Position(x: 1, y: 1),
        currentPosition: Position(x: 1, y: 1),
      );
      const puzzleEmpty = Puzzle(tiles: []);
      const puzzle1x1 = Puzzle(tiles: [tile]);
      const puzzle2x2 = Puzzle(tiles: [tile, tile, tile, tile]);

      test('returns 0 when given an empty list', () {
        expect(puzzleEmpty.getDimension(), equals(0));
      });

      test('returns 1 when given 1x1 list of tiles', () {
        expect(puzzle1x1.getDimension(), equals(1));
      });

      test('returns 2 when given 2x2 list of tiles', () {
        expect(puzzle2x2.getDimension(), equals(2));
      });
    });

    group('isSolvable', () {
      test('returns false when given an unsolvable odd puzzle', () {
        expect(unsolvableOddPuzzle.isSolvable(), isFalse);
      });

      test('returns false when given an unsolvable even puzzle', () {
        expect(unsolvableEvenPuzzle.isSolvable(), isFalse);
      });

      test('returns true when given a solvable odd puzzle', () {
        expect(solvableOddPuzzle.isSolvable(), isTrue);
      });

      test('returns true when given a solvable even puzzle', () {
        expect(solvableEvenPuzzle.isSolvable(), isTrue);
      });
    });

    group('countInversions', () {
      test('returns 1 when there is 1 inversion', () {
        expect(unsolvableOddPuzzle.countInversions(), equals(1));
      });

      test('returns 6 when there are 6 inversions', () {
        expect(solvableOddPuzzle.countInversions(), equals(6));
      });
    });
  });
}
