// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

void main() {
  group('DashatarPuzzleState', () {
    test('supports value comparisons', () {
      expect(
        DashatarPuzzleState(secondsToBegin: 3, isCountdownRunning: true),
        equals(
          DashatarPuzzleState(secondsToBegin: 3, isCountdownRunning: true),
        ),
      );
    });

    test('default isCountdownRunning is false', () {
      expect(
        DashatarPuzzleState(secondsToBegin: 3).isCountdownRunning,
        equals(false),
      );
    });

    group('status', () {
      test(
          'is loading '
          'when isCountdownRunning is true and '
          'secondsToBegin is greater than 0', () {
        expect(
          DashatarPuzzleState(
            secondsToBegin: 1,
            isCountdownRunning: true,
          ).status,
          equals(DashatarPuzzleStatus.loading),
        );
      });

      test(
          'is started '
          'when isCountdownRunning is false and '
          'secondsToBegin is equal to 0', () {
        expect(
          DashatarPuzzleState(
            secondsToBegin: 0,
          ).status,
          equals(DashatarPuzzleStatus.started),
        );
      });

      test(
          'is notStarted '
          'when isCountdownRunning is false and '
          'secondsToBegin is greater than 0', () {
        expect(
          DashatarPuzzleState(
            secondsToBegin: 3,
          ).status,
          equals(DashatarPuzzleStatus.notStarted),
        );
      });
    });

    group('copyWith', () {
      test('updates isCountdownRunning', () {
        expect(
          DashatarPuzzleState(
            secondsToBegin: 3,
            isCountdownRunning: true,
          ).copyWith(isCountdownRunning: false),
          equals(
            DashatarPuzzleState(
              secondsToBegin: 3,
            ),
          ),
        );
      });

      test('updates secondsToBegin', () {
        expect(
          DashatarPuzzleState(
            secondsToBegin: 3,
          ).copyWith(secondsToBegin: 1),
          equals(
            DashatarPuzzleState(
              secondsToBegin: 1,
            ),
          ),
        );
      });
    });
  });
}
