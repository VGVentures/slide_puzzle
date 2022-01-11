import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
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
class DashatarPuzzleTile extends StatelessWidget {
  /// {@macro dashatar_puzzle_tile}
  const DashatarPuzzleTile({
    Key? key,
    required this.tile,
    required this.state,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final size = state.puzzle.getDimension();
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

    return AnimatedAlign(
      alignment: FractionalOffset(
        (tile.currentPosition.x - 1) / (size - 1),
        (tile.currentPosition.y - 1) / (size - 1),
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
          onPressed: hasStarted && puzzleIncomplete
              ? () => context.read<PuzzleBloc>().add(TileTapped(tile))
              : null,
          icon: Image.asset(theme.dashAssetForTile(tile)),
        ),
      ),
    );
  }
}
