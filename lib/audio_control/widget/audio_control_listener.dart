import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';

/// {@template audio_control_listener}
/// Listens to the current audio status and mutes/unmutes [audioPlayer] accordingly.
/// {@endtemplate}
class AudioControlListener extends StatefulWidget {
  /// {@macro audio_control_listener}
  const AudioControlListener({
    Key? key,
    this.audioPlayer,
    required this.child,
  }) : super(key: key);

  /// The audio player to be muted/unmuted when the audio status changes.
  final AudioPlayer? audioPlayer;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  State<AudioControlListener> createState() => _AudioControlListenerState();
}

class _AudioControlListenerState extends State<AudioControlListener> {
  @override
  void didChangeDependencies() {
    updateAudioPlayer(muted: context.read<AudioControlBloc>().state.muted);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AudioControlListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateAudioPlayer(muted: context.read<AudioControlBloc>().state.muted);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioControlBloc, AudioControlState>(
      listener: (context, state) => updateAudioPlayer(muted: state.muted),
      child: widget.child,
    );
  }

  void updateAudioPlayer({required bool muted}) {
    widget.audioPlayer?.setVolume(muted ? 0.0 : 1.0);
  }
}
