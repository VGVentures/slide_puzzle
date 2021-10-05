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

  group('PuzzleState', () {
    test('supports value comparisons', () {
      expect(PuzzleState(), PuzzleState());
    });

    group('copyWith', () {
      test('returns same object when no properties are passed', () {
        expect(PuzzleState().copyWith(), equals(PuzzleState()));
      });

      test('returns object with updated puzzle when puzzle is passed', () {
        expect(
          PuzzleState().copyWith(puzzle: puzzle),
          equals(PuzzleState(puzzle: puzzle)),
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
  });
}
