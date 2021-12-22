// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

import '../../helpers/helpers.dart';

void main() {
  final ticker = MockTicker();
  final streamController = StreamController<int>.broadcast();

  setUp(() {
    when(ticker.tick).thenAnswer((_) => streamController.stream);
  });

  group('DashatarPuzzleBloc', () {
    test('initial state is correct', () {
      expect(
        DashatarPuzzleBloc(
          secondsToBegin: 3,
          ticker: ticker,
        ).state,
        equals(DashatarPuzzleState(secondsToBegin: 3)),
      );
    });

    group('DashatarCountdownStarted', () {
      test(
          'emits 4 sequential countdown states and '
          'then stops then countdown '
          'when secondsToBegin is 3', () async {
        final bloc = DashatarPuzzleBloc(secondsToBegin: 3, ticker: ticker)
          ..add(DashatarCountdownStarted());

        final state = await bloc.stream.first;
        expect(
          state,
          equals(
            DashatarPuzzleState(secondsToBegin: 3, isCountdownRunning: true),
          ),
        );

        streamController
          ..add(1)
          ..add(2)
          ..add(3)
          ..add(4)
          ..add(5);

        await expectLater(
          bloc.stream,
          emitsInOrder(<DashatarPuzzleState>[
            DashatarPuzzleState(secondsToBegin: 2, isCountdownRunning: true),
            DashatarPuzzleState(secondsToBegin: 1, isCountdownRunning: true),
            DashatarPuzzleState(secondsToBegin: 0, isCountdownRunning: true),
            DashatarPuzzleState(secondsToBegin: 0, isCountdownRunning: false),
          ]),
        );
      });
    });

    group('DashatarCountdownTicked', () {
      blocTest<DashatarPuzzleBloc, DashatarPuzzleState>(
        'decreases secondsToBegin by 1 '
        'if secondsToBegin is greater than 0',
        build: () => DashatarPuzzleBloc(secondsToBegin: 3, ticker: ticker),
        act: (bloc) => bloc.add(DashatarCountdownTicked()),
        expect: () => [DashatarPuzzleState(secondsToBegin: 2)],
      );

      blocTest<DashatarPuzzleBloc, DashatarPuzzleState>(
        'stops the countdown '
        'if secondsToBegin is equal to 0',
        build: () => DashatarPuzzleBloc(secondsToBegin: 0, ticker: ticker),
        seed: () =>
            DashatarPuzzleState(secondsToBegin: 0, isCountdownRunning: true),
        act: (bloc) => bloc..add(DashatarCountdownTicked()),
        expect: () => [
          DashatarPuzzleState(secondsToBegin: 0, isCountdownRunning: false),
        ],
      );
    });

    group('DashatarCountdownStopped', () {
      test(
          'stops the countdown and '
          'resets secondsToBegin', () async {
        final bloc = DashatarPuzzleBloc(secondsToBegin: 3, ticker: ticker)
          ..add(DashatarCountdownStarted());

        expect(
          await bloc.stream.first,
          equals(
            DashatarPuzzleState(isCountdownRunning: true, secondsToBegin: 3),
          ),
        );

        streamController.add(1);
        expect(
          await bloc.stream.first,
          equals(
            DashatarPuzzleState(isCountdownRunning: true, secondsToBegin: 2),
          ),
        );

        bloc.add(DashatarCountdownStopped());
        streamController.add(2);

        expect(
          await bloc.stream.first,
          equals(
            DashatarPuzzleState(isCountdownRunning: false, secondsToBegin: 3),
          ),
        );
      });
    });

    group('DashatarCountdownReset', () {
      test(
          'restarts the countdown '
          'with the given secondsToBegin', () async {
        final bloc = DashatarPuzzleBloc(secondsToBegin: 3, ticker: ticker)
          ..add(DashatarCountdownReset(secondsToBegin: 5));

        final state = await bloc.stream.first;
        expect(
          state,
          equals(
            DashatarPuzzleState(isCountdownRunning: true, secondsToBegin: 5),
          ),
        );

        streamController
          ..add(1)
          ..add(2)
          ..add(3)
          ..add(4)
          ..add(5)
          ..add(6)
          ..add(7)
          ..add(8)
          ..add(9)
          ..add(10);

        await expectLater(
          bloc.stream,
          emitsInOrder(<DashatarPuzzleState>[
            DashatarPuzzleState(isCountdownRunning: true, secondsToBegin: 4),
            DashatarPuzzleState(isCountdownRunning: true, secondsToBegin: 3),
            DashatarPuzzleState(isCountdownRunning: true, secondsToBegin: 2),
            DashatarPuzzleState(isCountdownRunning: true, secondsToBegin: 1),
            DashatarPuzzleState(isCountdownRunning: true, secondsToBegin: 0),
            DashatarPuzzleState(isCountdownRunning: false, secondsToBegin: 0),
          ]),
        );
      });
    });
  });
}
