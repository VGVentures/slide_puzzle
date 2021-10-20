// ignore_for_file: public_member_api_docs

part of 'timer_bloc.dart';

class TimerState extends Equatable {
  const TimerState({this.secondsElapsed = 0});

  final int secondsElapsed;

  @override
  List<Object> get props => [secondsElapsed];
}
