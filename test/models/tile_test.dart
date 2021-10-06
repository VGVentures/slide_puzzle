import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

void main() {
  const value = 1;
  const position = Position(x: 1, y: 1);
  const newPosition = Position(x: 2, y: 2);

  group('Tile', () {
    test('supports value comparisons', () {
      expect(
        const Tile(
          value: value,
          correctPosition: position,
          currentPosition: position,
        ),
        const Tile(
          value: value,
          correctPosition: position,
          currentPosition: position,
        ),
      );
    });

    group('copyWith', () {
      test('returns object with updated value when value is passed', () {
        expect(
          const Tile(
            value: value,
            correctPosition: position,
            currentPosition: position,
          ).copyWith(value: 2),
          equals(const Tile(
            value: 2,
            correctPosition: position,
            currentPosition: position,
          )),
        );
      });

      test(
          'returns object with updated correct position when correct position '
          'is passed', () {
        expect(
          const Tile(
            value: value,
            correctPosition: position,
            currentPosition: position,
          ).copyWith(correctPosition: newPosition),
          equals(
            const Tile(
              value: value,
              correctPosition: newPosition,
              currentPosition: position,
            ),
          ),
        );
      });

      test(
          'returns object with updated current position when current position '
          'is passed', () {
        expect(
          const Tile(
            value: value,
            correctPosition: position,
            currentPosition: position,
          ).copyWith(currentPosition: newPosition),
          equals(
            const Tile(
              value: value,
              correctPosition: position,
              currentPosition: newPosition,
            ),
          ),
        );
      });
    });
  });
}
