import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

/// {@template puzzle_theme}
/// Template for creating custom puzzle UI.
/// {@endtemplate}
abstract class PuzzleTheme extends Equatable {
  /// {@macro puzzle_theme}
  const PuzzleTheme();

  /// The display name of this theme.
  String get name;

  /// Whether this theme displays the puzzle timer.
  bool get hasTimer;

  /// Whether this theme displays the countdown
  /// from 3 to 0 seconds when the puzzle is started.
  bool get hasCountdown;

  /// The background color of this theme.
  Color get backgroundColor;

  /// The default color of this theme.
  ///
  /// Used for puzzle tiles and buttons.
  Color get defaultColor;

  /// The hover color of this theme.
  ///
  /// Used for the puzzle tile that was hovered over.
  Color get hoverColor;

  /// The pressed color of this theme.
  ///
  /// Used for the puzzle tile that was pressed.
  Color get pressedColor;

  /// The next tile color of this theme.
  ///
  /// Used for the puzzle tile that should be placed next.
  Color get nextTileColor;

  /// The locked tile color of this theme.
  ///
  /// Used for puzzle tiles that can't be moved.
  Color get lockedTileColor;

  /// The semi-locked color of this theme.
  ///
  /// Used for puzzle tiles that are placed, but aren't locked
  /// (ie. the second to last in each row.).
  Color get semiLockedTileColor;

  /// The cleared tile color of this theme.
  ///
  /// Used for puzzle tiles that are cleared, but aren't off screen
  Color get clearedTileColor;

  /// The color of the size-changing part of the timer.
  Color get timerForeground;

  /// The color of the background of the timer.
  Color get timerBackground;

  /// The puzzle layout delegate of this theme.
  ///
  /// Used for building sections of the puzzle UI.
  PuzzleLayoutDelegate get layoutDelegate;
}
