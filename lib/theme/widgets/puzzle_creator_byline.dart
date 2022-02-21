import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nftpuzzlefun/layout/layout.dart';
import 'package:nftpuzzlefun/theme/theme.dart';
import 'package:nftpuzzlefun/typography/typography.dart';

/// {@template puzzle_creator}
/// Displays the creator of the puzzle in the given color.
/// {@endtemplate}
class PuzzleCreatorByline extends StatelessWidget {
  /// {@macro puzzle_creator}
  const PuzzleCreatorByline({
    Key? key,
    required this.creator,
    this.color,
  }) : super(key: key);

  /// The creator to be displayed.
  final String creator;

  /// The color of [creator], defaults to [PuzzleTheme.creatorColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final creatorColor = color ?? theme.creatorColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(
        child: SizedBox(
          width: 300,
          child: Center(
            child: child,
          ),
        ),
      ),
      medium: (context, child) => Center(
        child: child,
      ),
      large: (context, child) => SizedBox(
        width: 300,
        child: child,
      ),
      child: (currentSize) {
        final textStyle = (currentSize == ResponsiveLayoutSize.large
                ? PuzzleTextStyle.headline2
                : PuzzleTextStyle.headline3)
            .copyWith(color: creatorColor);

        final textAlign = currentSize == ResponsiveLayoutSize.small
            ? TextAlign.center
            : TextAlign.left;

        return AnimatedDefaultTextStyle(
          style: textStyle,
          duration: PuzzleThemeAnimationDuration.textStyle,
          child: Text(
            creator,
            textAlign: textAlign,
          ),
        );
      },
    );
  }
}
