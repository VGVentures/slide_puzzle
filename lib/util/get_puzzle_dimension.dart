import 'dart:math';

import 'package:very_good_slide_puzzle/models/models.dart';

/// Get the dimension of a puzzle given its tile arrangement.
///
/// Ex: A 4x4 puzzle has a dimension of 4.
int getPuzzleDimension(List<Tile> tiles) {
  return sqrt(tiles.length).toInt();
}
