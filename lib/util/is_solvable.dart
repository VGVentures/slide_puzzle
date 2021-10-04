import 'package:very_good_slide_puzzle/models/models.dart';

/// Determines if the given tile arrangement is solvable.
bool isSolvable({required int size, required List<Tile> tiles}) {
  final height = tiles.length ~/ size;
  assert(size * height == tiles.length);
  final inversions = countInversions(size, tiles);

  if (size.isOdd) {
    return inversions.isEven;
  }

  final whitespace = tiles.singleWhere((tile) => tile.value == 0);
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
int countInversions(int size, List<Tile> tiles) {
  var count = 0;
  for (var a = 0; a < tiles.length; a++) {
    final tileA = tiles[a];
    if (tileA.value == 0) {
      continue;
    }

    for (var b = a + 1; b < tiles.length; b++) {
      final tileB = tiles[b];
      if (isInversion(tileA, tileB)) {
        count++;
      }
    }
  }
  return count;
}

/// Determines if the two tiles are inverted.
bool isInversion(Tile a, Tile b) {
  if (b.value != 0 && a.value != b.value) {
    if (b.value < a.value) {
      return b.currentPosition.compareTo(a.currentPosition) > 0;
    } else {
      return a.currentPosition.compareTo(b.currentPosition) > 0;
    }
  }
  return false;
}
