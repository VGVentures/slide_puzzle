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

  group('PuzzleState', () {
    test('supports value comparisons', () {
      expect(PuzzleState(), PuzzleState());
    });

    test('returns same object when no properties are passed', () {
      expect(PuzzleState().copyWith(), equals(PuzzleState()));
    });

    test('returns object with updated tiles when tiles are passed', () {
      expect(
        PuzzleState().copyWith(tiles: [tile]),
        equals(PuzzleState(tiles: [tile])),
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
  });
}
