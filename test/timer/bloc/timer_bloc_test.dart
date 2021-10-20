// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

class MockTicker extends Mock implements Ticker {}

void main() {
  final ticker = MockTicker();
  final streamController = StreamController<int>();

  setUp(() {
    when(ticker.tick).thenAnswer((_) => streamController.stream);
  });

  group('TimerBloc', () {
    test('initial state is TimerState', () {
      expect(
        TimerBloc(ticker: ticker).state,
        TimerState(),
      );
    });

    group('TimerStarted', () {
      blocTest<TimerBloc, TimerState>(
        'emits 3 sequential timer states',
        build: () => TimerBloc(ticker: ticker),
        act: (bloc) {
          bloc.add(TimerStarted());
          streamController
            ..add(1)
            ..add(2)
            ..add(3);
        },
        expect: () => <TimerState>[
          TimerState(secondsElapsed: 1),
          TimerState(secondsElapsed: 2),
          TimerState(secondsElapsed: 3),
        ],
      );
    });

    group('TimerTicked', () {
      blocTest<TimerBloc, TimerState>(
        'emits 1 when seconds elapsed is 1',
        build: () => TimerBloc(ticker: ticker),
        act: (bloc) => bloc.add(TimerTicked(1)),
        expect: () => [TimerState(secondsElapsed: 1)],
      );
    });

    group('TimerStopped', () {
      blocTest<TimerBloc, TimerState>(
        'emits 1 when seconds elapsed is 1',
        build: () => TimerBloc(ticker: ticker),
        act: (bloc) => bloc.add(TimerStopped(1)),
        expect: () => [TimerState(secondsElapsed: 1)],
      );
    });

    group('TimerReset', () {
      blocTest<TimerBloc, TimerState>(
        'emits new timer state',
        build: () => TimerBloc(ticker: ticker),
        act: (bloc) => bloc.add(TimerReset()),
        expect: () => [TimerState()],
      );
    });
  });
}
