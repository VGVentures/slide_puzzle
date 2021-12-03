import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template number_of_moves_and_tiles_left}
/// Displays how many moves have been made on the current puzzle
/// and how many puzzle tiles are not in their correct position.
/// {@endtemplate}
class NumberOfMovesAndTilesLeft extends StatelessWidget {
  /// {@macro number_of_moves_and_tiles_left}
  const NumberOfMovesAndTilesLeft({
    Key? key,
    required this.numberOfMoves,
    required this.numberOfTilesLeft,
    this.color,
  }) : super(key: key);

  /// The number of moves to be displayed.
  final int numberOfMoves;

  /// The number of tiles left to be displayed.
  final int numberOfTilesLeft;

  /// The color of texts that display [numberOfMoves] and [numberOfTilesLeft].
  /// Defaults to [PuzzleTheme.defaultColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final l10n = context.l10n;
    final textColor = color ?? theme.defaultColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(child: child),
      medium: (context, child) => Center(child: child),
      large: (context, child) => child!,
      child: (currentSize) {
        final bodyTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.bodySmall
            : PuzzleTextStyle.body;

        return RichText(
          key: const Key('numberOfMovesAndTilesLeft'),
          textAlign: TextAlign.center,
          text: TextSpan(
            text: numberOfMoves.toString(),
            style: PuzzleTextStyle.headline4.copyWith(
              color: textColor,
            ),
            children: [
              TextSpan(
                text: ' ${l10n.puzzleNumberOfMoves} | ',
                style: bodyTextStyle.copyWith(
                  color: textColor,
                ),
              ),
              TextSpan(
                text: numberOfTilesLeft.toString(),
                style: PuzzleTextStyle.headline4.copyWith(
                  color: textColor,
                ),
              ),
              TextSpan(
                text: ' ${l10n.puzzleNumberOfTilesLeft}',
                style: bodyTextStyle.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
