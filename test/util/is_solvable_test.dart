import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/position.dart';
import 'package:very_good_slide_puzzle/models/tile.dart';
import 'package:very_good_slide_puzzle/util/util.dart';

void main() {
  const unsolvableOddPuzzle = [
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
  ];

  const solvableOddPuzzle = [
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
  ];

  const unsolvableEvenPuzzle = [
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
  ];

  const solvableEvenPuzzle = [
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
  ];

  group('isInversion', () {
    const lesserPosition = Position(x: 1, y: 1);
    const greaterPosition = Position(x: 2, y: 1);
    test('returns true when the tiles are inverted', () {
      const tileA = Tile(
        value: 1,
        correctPosition: lesserPosition,
        currentPosition: greaterPosition,
      );
      const tileB = Tile(
        value: 2,
        correctPosition: greaterPosition,
        currentPosition: lesserPosition,
      );
      expect(isInversion(tileA, tileB), isTrue);
      expect(isInversion(tileB, tileA), isTrue);
    });

    test('returns false when the tiles are not inverted', () {
      const tileA = Tile(
        value: 1,
        correctPosition: lesserPosition,
        currentPosition: lesserPosition,
      );
      const tileB = Tile(
        value: 2,
        correctPosition: greaterPosition,
        currentPosition: greaterPosition,
      );
      expect(isInversion(tileA, tileB), isFalse);
      expect(isInversion(tileB, tileA), isFalse);
    });
  });

  group('countInversions', () {
    test('returns 1 when there is 1 inversion', () {
      expect(countInversions(3, unsolvableOddPuzzle), equals(1));
    });

    test('returns 6 when there are 6 inversions', () {
      expect(countInversions(3, solvableOddPuzzle), equals(6));
    });
  });

  group('isSolvable', () {
    test('returns false when given an unsolvable odd puzzle', () {
      expect(isSolvable(size: 3, tiles: unsolvableOddPuzzle), isFalse);
    });

    test('returns false when given an unsolvable even puzzle', () {
      expect(isSolvable(size: 4, tiles: unsolvableEvenPuzzle), isFalse);
    });

    test('returns true when given a solvable odd puzzle', () {
      expect(isSolvable(size: 3, tiles: solvableOddPuzzle), isTrue);
    });

    test('returns true when given a solvable even puzzle', () {
      expect(isSolvable(size: 2, tiles: solvableEvenPuzzle), isTrue);
    });
  });
}
