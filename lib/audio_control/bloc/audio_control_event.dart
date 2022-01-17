// ignore_for_file: public_member_api_docs

part of 'audio_control_bloc.dart';

abstract class AudioControlEvent extends Equatable {
  const AudioControlEvent();

  @override
  List<Object> get props => [];
}

class AudioToggled extends AudioControlEvent {}
