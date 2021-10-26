import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

void main() {
  const unsolvable3x3Tile0 = Tile(
    value: 0,
    correctPosition: Position(x: 3, y: 3),
    currentPosition: Position(x: 3, y: 3),
    isWhitespace: true,
  );
  const unsolvable3x3Tile1 = Tile(
    value: 1,
    correctPosition: Position(x: 1, y: 1),
    currentPosition: Position(x: 2, y: 1),
  );
  const unsolvable3x3Tile2 = Tile(
    value: 2,
    correctPosition: Position(x: 2, y: 1),
    currentPosition: Position(x: 1, y: 1),
  );
  const unsolvable3x3Tile3 = Tile(
    value: 3,
    correctPosition: Position(x: 3, y: 1),
    currentPosition: Position(x: 3, y: 1),
  );
  const unsolvable3x3Tile4 = Tile(
    value: 4,
    correctPosition: Position(x: 1, y: 2),
    currentPosition: Position(x: 1, y: 2),
  );
  const unsolvable3x3Tile5 = Tile(
    value: 5,
    correctPosition: Position(x: 2, y: 2),
    currentPosition: Position(x: 2, y: 2),
  );
  const unsolvable3x3Tile6 = Tile(
    value: 6,
    correctPosition: Position(x: 3, y: 2),
    currentPosition: Position(x: 3, y: 2),
  );
  const unsolvable3x3Tile7 = Tile(
    value: 7,
    correctPosition: Position(x: 1, y: 3),
    currentPosition: Position(x: 1, y: 3),
  );
  const unsolvable3x3Tile8 = Tile(
    value: 8,
    correctPosition: Position(x: 2, y: 3),
    currentPosition: Position(x: 2, y: 3),
  );
  const unsolvable3x3Puzzle = Puzzle(
    tiles: [
      unsolvable3x3Tile0,
      unsolvable3x3Tile1,
      unsolvable3x3Tile2,
      unsolvable3x3Tile3,
      unsolvable3x3Tile4,
      unsolvable3x3Tile5,
      unsolvable3x3Tile6,
      unsolvable3x3Tile7,
      unsolvable3x3Tile8,
    ],
  );

  const solvable3x3Puzzle = Puzzle(
    tiles: [
      Tile(
        value: 2,
        correctPosition: Position(x: 2, y: 1),
        currentPosition: Position(x: 3, y: 2),
      ),
      Tile(
        value: 1,
        correctPosition: Position(x: 1, y: 1),
        currentPosition: Position(x: 1, y: 1),
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
        isWhitespace: true,
      ),
    ],
  );

  const unsolvable4x4Puzzle = Puzzle(
    tiles: [
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
        isWhitespace: true,
      ),
    ],
  );

  const solvable2x2Tile0 = Tile(
    value: 0,
    correctPosition: Position(x: 2, y: 2),
    currentPosition: Position(x: 1, y: 1),
    isWhitespace: true,
  );
  const solvable2x2Tile1 = Tile(
    value: 1,
    correctPosition: Position(x: 1, y: 1),
    currentPosition: Position(x: 2, y: 1),
  );
  const solvable2x2Tile2 = Tile(
    value: 2,
    correctPosition: Position(x: 2, y: 1),
    currentPosition: Position(x: 2, y: 2),
  );
  const solvable2x2Tile3 = Tile(
    value: 3,
    correctPosition: Position(x: 1, y: 2),
    currentPosition: Position(x: 1, y: 2),
  );
  const solvable2x2Puzzle = Puzzle(
    tiles: [
      solvable2x2Tile0,
      solvable2x2Tile1,
      solvable2x2Tile2,
      solvable2x2Tile3,
    ],
  );

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

    group('getWhitespaceTile', () {
      test('returns correct whitespace tile from 2x2 puzzle', () {
        expect(solvable2x2Puzzle.getWhitespaceTile(), equals(solvable2x2Tile0));
      });
    });

    group('getNumberOfCorrectTiles', () {
      test('returns 0 from 1x1 puzzle with only a whitespace tile', () {
        const puzzle = Puzzle(
          tiles: [
            Tile(
              value: 0,
              correctPosition: Position(x: 1, y: 1),
              currentPosition: Position(x: 1, y: 1),
              isWhitespace: true,
            ),
          ],
        );
        expect(puzzle.getNumberOfCorrectTiles(), equals(0));
      });

      test('returns 1 from 2x2 puzzle with 1 correct tile', () {
        expect(solvable2x2Puzzle.getNumberOfCorrectTiles(), equals(1));
      });

      test('returns 6 from 3x3 puzzle with 6 correct tiles', () {
        expect(unsolvable3x3Puzzle.getNumberOfCorrectTiles(), equals(6));
      });
    });

    group('isTileMoveable', () {
      test('returns true when tile is adjacent to whitespace', () {
        expect(solvable2x2Puzzle.isTileMovable(solvable2x2Tile3), isTrue);
      });

      test('returns false when tile is not adjacent to whitespace', () {
        expect(solvable2x2Puzzle.isTileMovable(solvable2x2Tile2), isFalse);
      });

      test('returns true when tile is in same row/column as whitespace', () {
        expect(unsolvable3x3Puzzle.isTileMovable(unsolvable3x3Tile3), isTrue);
      });

      test('returns false when tile is not in same row/column as whitespace',
          () {
        expect(unsolvable3x3Puzzle.isTileMovable(unsolvable3x3Tile2), isFalse);
      });
    });

    group('isSolvable', () {
      test('returns false when given an unsolvable 3x3 puzzle', () {
        expect(unsolvable3x3Puzzle.isSolvable(), isFalse);
      });

      test('returns false when given an unsolvable 4x4 puzzle', () {
        expect(unsolvable4x4Puzzle.isSolvable(), isFalse);
      });

      test('returns true when given a solvable 3x3 puzzle', () {
        expect(solvable3x3Puzzle.isSolvable(), isTrue);
      });

      test('returns true when given a solvable 2x2 puzzle', () {
        expect(solvable2x2Puzzle.isSolvable(), isTrue);
      });
    });

    group('countInversions', () {
      test('returns 1 when there is 1 inversion', () {
        expect(unsolvable3x3Puzzle.countInversions(), equals(1));
      });

      test('returns 6 when there are 6 inversions', () {
        expect(solvable3x3Puzzle.countInversions(), equals(6));
      });
    });

    group('moveTiles', () {
      test(
          'moves one tile that is adjacent to the whitespace to the '
          'position of the whitespace tile', () {
        final mutableSolvable2x2Puzzle =
            Puzzle(tiles: [...solvable2x2Puzzle.tiles]);
        final newPuzzle = Puzzle(
          tiles: [
            solvable2x2Tile0.copyWith(
              currentPosition: solvable2x2Tile3.currentPosition,
            ),
            solvable2x2Tile1,
            solvable2x2Tile2,
            solvable2x2Tile3.copyWith(
              currentPosition: solvable2x2Tile0.currentPosition,
            ),
          ],
        );
        expect(
          mutableSolvable2x2Puzzle.moveTiles(solvable2x2Tile3, []),
          newPuzzle,
        );
      });

      test(
          'moves multiple tiles that are in the same row/column as the '
          'whitespace tile', () {
        final mutableUnsolvable3x3Puzzle =
            Puzzle(tiles: [...unsolvable3x3Puzzle.tiles]);
        final newPuzzle = Puzzle(
          tiles: [
            unsolvable3x3Tile0.copyWith(
              currentPosition: unsolvable3x3Tile3.currentPosition,
            ),
            unsolvable3x3Tile1,
            unsolvable3x3Tile2,
            unsolvable3x3Tile3.copyWith(
              currentPosition: unsolvable3x3Tile6.currentPosition,
            ),
            unsolvable3x3Tile4,
            unsolvable3x3Tile5,
            unsolvable3x3Tile6.copyWith(
              currentPosition: unsolvable3x3Tile0.currentPosition,
            ),
            unsolvable3x3Tile7,
            unsolvable3x3Tile8,
          ],
        );
        expect(
          mutableUnsolvable3x3Puzzle.moveTiles(unsolvable3x3Tile3, []),
          newPuzzle,
        );
      });
    });

    group('sort', () {
      test('returns a puzzle with tiles sorted by their current positions', () {
        const sortedPuzzle = Puzzle(
          tiles: [
            solvable2x2Tile0,
            solvable2x2Tile1,
            solvable2x2Tile3,
            solvable2x2Tile2,
          ],
        );
        expect(solvable2x2Puzzle.sort(), sortedPuzzle);
      });
    });
  });
}
