// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

void main() {
  const elaspsedSeconds = 1;

  group('TimerEvent', () {
    group('TimerStarted', () {
      test('supports value comparisons', () {
        expect(TimerStarted(), equals(TimerStarted()));
      });
    });

    group('TimerTicked', () {
      test('supports value comparisons', () {
        expect(
          TimerTicked(elaspsedSeconds),
          equals(TimerTicked(elaspsedSeconds)),
        );
      });
    });

    group('TimerStopped', () {
      test('supports value comparisons', () {
        expect(
          TimerStopped(),
          equals(TimerStopped()),
        );
      });
    });

    group('TimerReset', () {
      test('supports value comparisons', () {
        expect(TimerReset(), equals(TimerReset()));
      });
    });
  });
}
