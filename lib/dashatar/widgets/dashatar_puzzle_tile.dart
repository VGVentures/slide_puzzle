import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

abstract class _TileSize {
  static double small = 75;
  static double medium = 100;
  static double large = 112;
}

/// {@template dashatar_puzzle_tile}
/// Displays the puzzle tile associated with [tile]
/// based on the puzzle [state].
/// {@endtemplate}
class DashatarPuzzleTile extends StatefulWidget {
  /// {@macro dashatar_puzzle_tile}
  const DashatarPuzzleTile({
    Key? key,
    required this.tile,
    required this.state,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The state of the puzzle.
  final PuzzleState state;

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<DashatarPuzzleTile> createState() => _DashatarPuzzleTileState();
}

class _DashatarPuzzleTileState extends State<DashatarPuzzleTile>
    with SingleTickerProviderStateMixin {
  AudioPlayer? _audioPlayer;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();

    // Delay the initialization of the audio player for performance reasons,
    // to avoid dropping frames when the theme is changed.
    _timer = Timer(const Duration(seconds: 1), () {
      _audioPlayer = widget._audioPlayerFactory()
        ..setAsset('assets/audio/tile_move.mp3');
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.state.puzzle.getDimension();
    final theme = context.select((DashatarThemeBloc bloc) => bloc.state.theme);
    final status =
        context.select((DashatarPuzzleBloc bloc) => bloc.state.status);
    final hasStarted = status == DashatarPuzzleStatus.started;
    final puzzleIncomplete =
        context.select((PuzzleBloc bloc) => bloc.state.puzzleStatus) ==
            PuzzleStatus.incomplete;

    final movementDuration = status == DashatarPuzzleStatus.loading
        ? const Duration(milliseconds: 800)
        : const Duration(milliseconds: 370);

    final canPress = hasStarted && puzzleIncomplete;

    return AnimatedAlign(
      alignment: FractionalOffset(
        (widget.tile.currentPosition.x - 1) / (size - 1),
        (widget.tile.currentPosition.y - 1) / (size - 1),
      ),
      duration: movementDuration,
      curve: Curves.easeInOut,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox.square(
          key: const Key('dashatar_puzzle_tile_small'),
          dimension: _TileSize.small,
          child: child,
        ),
        medium: (_, child) => SizedBox.square(
          key: const Key('dashatar_puzzle_tile_medium'),
          dimension: _TileSize.medium,
          child: child,
        ),
        large: (_, child) => SizedBox.square(
          key: const Key('dashatar_puzzle_tile_large'),
          dimension: _TileSize.large,
          child: child,
        ),
        child: (_) => IconButton(
          padding: EdgeInsets.zero,
          onPressed: canPress
              ? () {
                  context.read<PuzzleBloc>().add(TileTapped(widget.tile));
                  unawaited(_audioPlayer?.replay());
                }
              : null,
          icon: Image.asset(
            theme.dashAssetForTile(widget.tile),
            semanticLabel: context.l10n.puzzleTileLabelText(
              widget.tile.value.toString(),
              widget.tile.currentPosition.x.toString(),
              widget.tile.currentPosition.y.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
