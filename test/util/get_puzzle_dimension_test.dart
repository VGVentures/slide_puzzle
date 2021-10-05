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
  final tiles1x1 = [tile];
  final tiles2x2 = [tile, tile, tile, tile];

  group('getPuzzleDimension', () {
    test('returns 0 when given an empty list', () {
      expect(getPuzzleDimension([]), equals(0));
    });

    test('returns 1 when given 1x1 list of tiles', () {
      expect(getPuzzleDimension(tiles1x1), equals(1));
    });

    test('returns 2 when given 2x2 list of tiles', () {
      expect(getPuzzleDimension(tiles2x2), equals(2));
    });
  });
}
