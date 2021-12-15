// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

void main() {
  group('TimerState', () {
    test('supports value comparisons', () {
      expect(TimerState(), equals(TimerState()));
    });

    group('copyWith', () {
      test('updates isRunning', () {
        expect(
          TimerState(
            isRunning: true,
            secondsElapsed: 3,
          ).copyWith(isRunning: false),
          equals(
            TimerState(
              isRunning: false,
              secondsElapsed: 3,
            ),
          ),
        );
      });

      test('updates secondsElapsed', () {
        expect(
          TimerState(
            isRunning: true,
            secondsElapsed: 3,
          ).copyWith(secondsElapsed: 4),
          equals(
            TimerState(
              isRunning: true,
              secondsElapsed: 4,
            ),
          ),
        );
      });
    });
  });
}
