// ignore_for_file: public_member_api_docs

part of 'dashatar_puzzle_bloc.dart';

abstract class DashatarPuzzleEvent extends Equatable {
  const DashatarPuzzleEvent();

  @override
  List<Object?> get props => [];
}

class DashatarCountdownStarted extends DashatarPuzzleEvent {
  const DashatarCountdownStarted();
}

class DashatarCountdownTicked extends DashatarPuzzleEvent {
  const DashatarCountdownTicked();
}

class DashatarCountdownStopped extends DashatarPuzzleEvent {
  const DashatarCountdownStopped();
}

class DashatarCountdownReset extends DashatarPuzzleEvent {
  const DashatarCountdownReset({this.secondsToBegin});

  /// The number of seconds to countdown from.
  /// Defaults to [DashatarPuzzleBloc.secondsToBegin] if null.
  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];
}
