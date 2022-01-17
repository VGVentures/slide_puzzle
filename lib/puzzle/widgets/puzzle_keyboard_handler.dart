import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

/// {@template puzzle_keyboard_handler}
/// A widget that listens to the keyboard events and moves puzzle tiles
/// whenever a user presses keyboard arrows (←, →, ↑, ↓).
/// {@endtemplate}
class PuzzleKeyboardHandler extends StatefulWidget {
  /// {@macro puzzle_keyboard_handler}
  const PuzzleKeyboardHandler({
    Key? key,
    required this.child,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State createState() => _PuzzleKeyboardHandlerState();
}

class _PuzzleKeyboardHandlerState extends State<PuzzleKeyboardHandler> {
  // The node used to request the keyboard focus.
  final FocusNode _focusNode = FocusNode();

  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/tile_move.mp3');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    final theme = context.read<ThemeBloc>().state.theme;

    // The user may move tiles only when the puzzle is started.
    // There's no need to check the Simple theme as it is started by default.
    final canMoveTiles = !(theme is DashatarTheme &&
        context.read<DashatarPuzzleBloc>().state.status !=
            DashatarPuzzleStatus.started);

    if (event is RawKeyDownEvent && canMoveTiles) {
      final puzzle = context.read<PuzzleBloc>().state.puzzle;
      final physicalKey = event.data.physicalKey;

      Tile? tile;
      if (physicalKey == PhysicalKeyboardKey.arrowDown) {
        tile = puzzle.getTileRelativeToWhitespaceTile(const Offset(0, -1));
      } else if (physicalKey == PhysicalKeyboardKey.arrowUp) {
        tile = puzzle.getTileRelativeToWhitespaceTile(const Offset(0, 1));
      } else if (physicalKey == PhysicalKeyboardKey.arrowRight) {
        tile = puzzle.getTileRelativeToWhitespaceTile(const Offset(-1, 0));
      } else if (physicalKey == PhysicalKeyboardKey.arrowLeft) {
        tile = puzzle.getTileRelativeToWhitespaceTile(const Offset(1, 0));
      }

      if (tile != null) {
        context.read<PuzzleBloc>().add(TileTapped(tile));
        unawaited(_audioPlayer.replay());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        child: Builder(
          builder: (context) {
            if (!_focusNode.hasFocus) {
              FocusScope.of(context).requestFocus(_focusNode);
            }
            return widget.child;
          },
        ),
      ),
    );
  }
}
