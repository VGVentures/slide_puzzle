// ignore_for_file: public_member_api_docs

part of 'timer_bloc.dart';

class TimerState extends Equatable {
  const TimerState({
    this.isRunning = false,
    this.secondsElapsed = 0,
  });

  final bool isRunning;
  final int secondsElapsed;

  @override
  List<Object> get props => [isRunning, secondsElapsed];

  TimerState copyWith({
    bool? isRunning,
    int? secondsElapsed,
  }) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      secondsElapsed: secondsElapsed ?? this.secondsElapsed,
    );
  }
}
