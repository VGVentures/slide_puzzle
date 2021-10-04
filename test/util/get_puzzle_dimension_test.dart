import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/position.dart';
import 'package:very_good_slide_puzzle/models/tile.dart';
import 'package:very_good_slide_puzzle/util/util.dart';

void main() {
  const tile = Tile(
    value: 1,
    correctPosition: Position(x: 1, y: 1),
    currentPosition: Position(x: 1, y: 1),
  );
  final tiles = [tile, tile, tile, tile];

  group('getPuzzleDimension', () {
    test('returns 2 when given 4x4 list of tiles', () {
      expect(getPuzzleDimension(tiles), equals(2));
    });
  });
}
