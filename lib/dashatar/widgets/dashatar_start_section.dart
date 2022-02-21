import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nftpuzzlefun/dashatar/dashatar.dart';
import 'package:nftpuzzlefun/l10n/l10n.dart';
import 'package:nftpuzzlefun/layout/layout.dart';
import 'package:nftpuzzlefun/puzzle/puzzle.dart';
import 'package:nftpuzzlefun/theme/theme.dart';
import 'package:nftpuzzlefun/theme/widgets/puzzle_creator_byline.dart';

/// {@template dashatar_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class DashatarStartSection extends StatelessWidget {
  /// {@macro dashatar_start_section}
  const DashatarStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((DashatarPuzzleBloc bloc) => bloc.state.status);
    final artworkState = context.watch<ArtworkBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 83,
          large: 151,
        ),
        PuzzleName(
          key: puzzleNameKey,
        ),
        const ResponsiveGap(large: 16),
        PuzzleTitle(
          key: puzzleTitleKey,
          title: artworkState.selectedArtwork!.name,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        PuzzleCreatorByline(
          key: puzzleCreatorBylineKey,
          creator: artworkState.selectedArtwork!.creator,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        NumberOfMovesAndTilesLeft(
          key: numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: status == DashatarPuzzleStatus.started
              ? state.numberOfTilesLeft
              : state.puzzle.tiles.length - 1,
        ),
        const ResponsiveGap(
          small: 8,
          medium: 18,
          large: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => const DashatarPuzzleActionButton(),
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const DashatarTimer(),
          medium: (_, __) => const DashatarTimer(),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(small: 12),
      ],
    );
  }
}
