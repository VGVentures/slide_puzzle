// ignore_for_file: public_member_api_docs

part of 'audio_control_bloc.dart';

class AudioControlState extends Equatable {
  const AudioControlState({
    this.muted = false,
  });

  /// Whether the audio is muted.
  final bool muted;

  @override
  List<Object> get props => [muted];
}
