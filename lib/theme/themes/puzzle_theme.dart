import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// {@template puzzle_tile}
/// Template for creating custom puzzle UI.
/// {@endtemplate}
abstract class PuzzleTheme extends Equatable {
  /// {@macro puzzle_tile}
  const PuzzleTheme();

  /// Display name of the theme.
  String get name;

  /// Scaffold containing the [puzzleWrapper].
  ///
  /// [body] is the widget defined in [puzzleWrapper].
  Scaffold appScaffold({required Widget body});

  /// Widget wrapping around the puzzle components (listed below).
  ///
  /// [child] is a column containing [themeTabBar], [puzzleBoard], and puzzle
  /// information.
  ///
  /// The puzzle information is a row containing [resetIcon], [movesCounter],
  /// [tilesLeftCounter], and [timer].
  ///
  /// See PuzzlePage to modify or re-arrange the [child] widget tree.
  Widget puzzleWrapper({required Widget child});

  /// GridView displaying puzzle tiles.
  ///
  /// A [size] is a dimension of a puzzle
  /// (e.g. 4x4 puzzle has a dimension of 4).
  GridView puzzleBoard({required int size, required List<Widget> children});

  /// TabBar displaying puzzle themes.
  ///
  /// [onTap] must be supplied to the TabBar's onTap property
  /// for theme switching.
  TabBar themeTabBar({
    required List<PuzzleTheme> themes,
    required void Function(int) onTap,
  });

  /// Widget representing a puzzle tile.
  ///
  /// [value] is the number associated with the tile. To complete the puzzle,
  /// all tiles must be arranged in order by their [value].
  Widget tile(int value);

  /// Widget representing the whitespace tile.
  Widget get whitespaceTile;

  /// Widget representing the whitespace tile when the puzzle is complete.
  Widget get whitespaceTileComplete;

  /// Widget representing the reset button icon.
  Widget get resetIcon;

  /// Widget to display the number of moves made in the puzzle.
  Widget movesCounter(int moves);

  /// Widget to display the number of tiles left/tiles not in their correct
  /// position.
  Widget tilesLeftCounter(int tilesLeft);

  /// Widget to display the seconds passed since the puzzle was started.
  Widget timer(int seconds);
}
