import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

part 'dashatar_puzzle_event.dart';
part 'dashatar_puzzle_state.dart';

/// {@template dashatar_puzzle_bloc}
/// A bloc responsible for starting the Dashatar puzzle.
/// {@endtemplate}
class DashatarPuzzleBloc
    extends Bloc<DashatarPuzzleEvent, DashatarPuzzleState> {
  /// {@macro dashatar_puzzle_bloc}
  DashatarPuzzleBloc({
    required this.secondsToBegin,
    required Ticker ticker,
  })  : _ticker = ticker,
        super(DashatarPuzzleState(secondsToBegin: secondsToBegin)) {
    on<DashatarCountdownStarted>(_onCountdownStarted);
    on<DashatarCountdownTicked>(_onCountdownTicked);
    on<DashatarCountdownStopped>(_onCountdownStopped);
    on<DashatarCountdownReset>(_onCountdownReset);
  }

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _startTicker() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick().listen((_) => add(const DashatarCountdownTicked()));
  }

  void _onCountdownStarted(
    DashatarCountdownStarted event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownTicked(
    DashatarCountdownTicked event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    if (state.secondsToBegin == 0) {
      _tickerSubscription?.pause();
      emit(state.copyWith(isCountdownRunning: false));
    } else {
      emit(state.copyWith(secondsToBegin: state.secondsToBegin - 1));
    }
  }

  void _onCountdownStopped(
    DashatarCountdownStopped event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    _tickerSubscription?.pause();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownReset(
    DashatarCountdownReset event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: event.secondsToBegin ?? secondsToBegin,
      ),
    );
  }
}
