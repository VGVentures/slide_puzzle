import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

// A 3x3 puzzle board visualization:
//
//   ┌─────1───────2───────3────► x
//   │  ┌─────┐ ┌─────┐ ┌─────┐
//   1  │  1  │ │  2  │ │  3  │
//   │  └─────┘ └─────┘ └─────┘
//   │  ┌─────┐ ┌─────┐ ┌─────┐
//   2  │  4  │ │  5  │ │  6  │
//   │  └─────┘ └─────┘ └─────┘
//   │  ┌─────┐ ┌─────┐
//   3  │  7  │ │  8  │
//   │  └─────┘ └─────┘
//   ▼
//   y
//
// This puzzle is in its completed state (i.e. the tiles are arranged in
// ascending order by value from top to bottom, left to right).
//
// Each tile has a value (1-8 on example above), and a correct and current
// position.
//
// The correct position is where the tile should be in the completed
// puzzle. As seen from example above, tile 2's correct position is (2, 1).
// The current position is where the tile is currently located on the board.

/// {@template puzzle}
/// Model for a puzzle.
/// {@endtemplate}
class Puzzle extends Equatable {
  /// {@macro puzzle}
  const Puzzle({required this.tiles, required this.rowsCleared});

  /// List of [Tile]s representing the puzzle's current arrangement.
  final List<Tile> tiles;

  /// The number of rows that have already been cleared.
  final int rowsCleared;

  /// Get the list of tiles in the top row.
  ///
  /// Throws a [StateError] if the top row isn't full of tiles
  List<Tile> getTopRow() {
    final topRow = tiles.where((t) => t.currentPosition.y == 1).toList();
    if (topRow.length < getDimension()) {
      throw StateError(
        'The top row is not accessible without initializing tiles.',
      );
    }
    return topRow;
  }

  /// Get the tile currently at the given [Position].
  ///
  /// Throws a [StateError] if there is no tile there.
  Tile getTileAt(Position currentPosition) =>
      tiles.firstWhere((t) => t.currentPosition == currentPosition);

  /// Get the tile that was last at the given [Position].
  ///
  /// Throws a [StateError] if there is no tile meeting the criteria.
  Tile getTileLastAt(Position position) => tiles.firstWhere(
        (t) => t.lastPosition == position,
      );

  /// Get the tile with the given value.
  ///
  /// Throws a [StateError] if there is no tile there.
  Tile getTileWithValue(int value) => tiles.firstWhere((t) => t.value == value);

  /// Get the dimension of a puzzle given its tile arrangement.
  ///
  /// Ex: A 4x4 puzzle has a dimension of 4.
  int getDimension() {
    return sqrt(tiles.length).toInt();
  }

  /// Get the single whitespace tile object in the puzzle.
  Tile getWhitespaceTile() {
    return tiles.singleWhere((tile) => tile.isWhitespace);
  }

  /// Gets the number of tiles that are currently in their correct position.
  int getNumberOfCorrectTiles() {
    final whitespaceTile = getWhitespaceTile();
    var numberOfCorrectTiles = 0;
    for (final tile in tiles) {
      if (tile != whitespaceTile) {
        if (tile.currentPosition.x == tile.correctPosition.x &&
            rowsCleared == tile.correctPosition.y - 1) {
          numberOfCorrectTiles++;
        }
      }
    }
    return numberOfCorrectTiles;
  }

  /// Gets the next tile in the row to be placed.
  ///
  /// Returns null if the puzzle isn't initialized yet.
  /// Throws StateError if top row is fully solved.
  Tile? getNextTile() {
    if (tiles.isEmpty) {
      return null;
    }
    final firstWrong = getTopRow().firstWhere(
      (tile) =>
          tile.correctPosition.y != rowsCleared + 1 ||
          tile.currentPosition.x != tile.correctPosition.x ||
          tile.isWhitespace,
    );
    return tiles.firstWhere(
      (test) =>
          test.correctPosition.x == firstWrong.currentPosition.x &&
          test.correctPosition.y == rowsCleared + 1,
    );
  }

  /// Determines if the puzzle is completed.
  bool isComplete() {
    return (tiles.length - 1) - getNumberOfCorrectTiles() == 0;
  }

  /// Determines if the top row of the puzzle is solved.
  bool isTopRowSolved() {
    final topRow = getTopRow();
    return topRow.every(
      (t) =>
          t.correctPosition.x == t.currentPosition.x &&
          t.correctPosition.y == rowsCleared + 1 &&
          !t.isWhitespace,
    );
  }

  /// Determines if the tapped tile can move in the direction of the whitespace
  /// tile.
  bool isTileMovable(Tile tile) {
    final whitespaceTile = getWhitespaceTile();
    if (tile == whitespaceTile) {
      return false;
    }

    // A tile must be in the same row or column as the whitespace to move.
    if (whitespaceTile.currentPosition.x != tile.currentPosition.x &&
        whitespaceTile.currentPosition.y != tile.currentPosition.y) {
      return false;
    }

    // If a tile is locked, it can't be moved (all but last two in top row will
    // lock into place after being correct).
    if (tile.value < getNextTile()!.value &&
        tile.correctPosition.x < getDimension() - 1) {
      return false;
    }

    return true;
  }

  /// Determines if the puzzle is solvable.
  bool isSolvable() {
    final size = getDimension();
    final height = tiles.length ~/ size;
    assert(
      size * height == tiles.length,
      'tiles must be equal to size * height',
    );
    final inversions = countInversions();

    if (size.isOdd) {
      return inversions.isEven;
    }

    final whitespace = tiles.singleWhere((tile) => tile.isWhitespace);
    final whitespaceRow = whitespace.currentPosition.y;

    if (((height - whitespaceRow) + 1).isOdd) {
      return inversions.isEven;
    } else {
      return inversions.isOdd;
    }
  }

  /// Gives the number of inversions in a puzzle given its tile arrangement.
  ///
  /// An inversion is when a tile of a lower value is in a greater position than
  /// a tile of a higher value.
  int countInversions() {
    var count = 0;
    for (var a = 0; a < tiles.length; a++) {
      final tileA = tiles[a];
      if (tileA.isWhitespace) {
        continue;
      }

      for (var b = a + 1; b < tiles.length; b++) {
        final tileB = tiles[b];
        if (_isInversion(tileA, tileB)) {
          count++;
        }
      }
    }
    return count;
  }

  /// Determines if the two tiles are inverted.
  bool _isInversion(Tile a, Tile b) {
    if (!b.isWhitespace && a.value != b.value) {
      if (b.value < a.value) {
        return b.currentPosition.compareTo(a.currentPosition) > 0;
      } else {
        return a.currentPosition.compareTo(b.currentPosition) > 0;
      }
    }
    return false;
  }

  /// Shifts one or many tiles in a row/column with the whitespace and returns
  /// the modified puzzle.
  ///
  // Recursively stores a list of all tiles that need to be moved and passes the
  // list to _swapTiles to individually swap them.
  Puzzle moveTile(Tile tile) {
    for (var i = 0; i < tiles.length; ++i) {
      tiles[i] = tiles[i].clearLastPosition();
    }
    return _moveTilesHelper(tile, []);
  }

  /// Shifts one or many tiles in a row/column with the whitespace and returns
  /// the modified puzzle.
  ///
  // Recursively stores a list of all tiles that need to be moved and passes the
  // list to _swapTiles to individually swap them.
  Puzzle _moveTilesHelper(Tile tile, List<Tile> tilesToSwap) {
    final whitespaceTile = getWhitespaceTile();
    final deltaX = whitespaceTile.currentPosition.x - tile.currentPosition.x;
    final deltaY = whitespaceTile.currentPosition.y - tile.currentPosition.y;

    if ((deltaX.abs() + deltaY.abs()) > 1) {
      final shiftPointX = tile.currentPosition.x + deltaX.sign;
      final shiftPointY = tile.currentPosition.y + deltaY.sign;
      final tileToSwapWith = tiles.singleWhere(
        (tile) =>
            tile.currentPosition.x == shiftPointX &&
            tile.currentPosition.y == shiftPointY,
      );
      tilesToSwap.add(tile);
      return _moveTilesHelper(tileToSwapWith, tilesToSwap);
    } else {
      tilesToSwap.add(tile);
      return _swapTiles(tilesToSwap);
    }
  }

  /// Returns puzzle with new tile arrangement after individually swapping each
  /// tile in tilesToSwap with the whitespace.
  Puzzle _swapTiles(List<Tile> tilesToSwap) {
    for (final tileToSwap in tilesToSwap.reversed) {
      final tileIndex = tiles.indexWhere((t) => t.value == tileToSwap.value);
      final tile = tiles[tileIndex];
      final whitespaceTile = getWhitespaceTile();
      final whitespaceTileIndex = tiles.indexOf(whitespaceTile);

      // Swap current board positions of the moving tile and the whitespace.
      tiles[tileIndex] = tile.copyWith(
        currentPosition: whitespaceTile.currentPosition,
      );
      tiles[whitespaceTileIndex] = whitespaceTile.copyWith(
        currentPosition: tile.currentPosition,
      );
    }

    return Puzzle(tiles: tiles, rowsCleared: rowsCleared);
  }

  /// Add the given row of [Tile]s to the bottom of the puzzle.
  ///
  /// Throws a [StateError] if the top row isn't fully complete.
  Puzzle pushRow(List<Tile> newRow) {
    final dimension = getDimension();
    assert(newRow.length == dimension, 'New row must have correct dimension.');
    assert(
      newRow.every((t) => t.currentPosition.y == dimension),
      'New row tiles must all be in the last row.',
    );

    if (!isTopRowSolved()) {
      throw StateError('Unable to add row when top row is unsolved.');
    }

    final remainingTiles = tiles
        .where((t) => t.currentPosition.y > 1)
        .map(
          (t) => t.copyWith(
            currentPosition:
                Position(x: t.currentPosition.x, y: t.currentPosition.y - 1),
          ),
        )
        .toList();
    return Puzzle(tiles: remainingTiles + newRow, rowsCleared: rowsCleared + 1);
  }

  /// Sorts puzzle tiles so they are in order of their current position.
  Puzzle sort() {
    final sortedTiles = tiles.toList()
      ..sort((tileA, tileB) {
        return tileA.currentPosition.compareTo(tileB.currentPosition);
      });
    return Puzzle(tiles: sortedTiles, rowsCleared: rowsCleared);
  }

  @override
  List<Object> get props => [tiles];
}
