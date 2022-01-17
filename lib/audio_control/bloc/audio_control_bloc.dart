// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audio_control_event.dart';
part 'audio_control_state.dart';

class AudioControlBloc extends Bloc<AudioControlEvent, AudioControlState> {
  AudioControlBloc() : super(const AudioControlState()) {
    on<AudioToggled>(_onAudioToggled);
  }

  void _onAudioToggled(AudioToggled event, Emitter<AudioControlState> emit) {
    emit(AudioControlState(muted: !state.muted));
  }
}
