import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/layout/puzzle_layout_delegate.dart';

/// {@template puzzle_theme}
/// Template for creating custom puzzle UI.
/// {@endtemplate}
abstract class PuzzleTheme extends Equatable {
  /// {@macro puzzle_theme}
  const PuzzleTheme();

  /// The hover color of this theme.
  ///
  /// Applied to the background color of a puzzle tile
  /// that is hovered over.
  Color get hoverColor;

  /// The pressed color of this theme.
  ///
  /// Applied to the background color of a puzzle tile
  /// that was pressed.
  Color get pressedColor;

  /// The puzzle layout delegate of this theme.
  ///
  /// Used for building sections of the puzzle UI.
  PuzzleLayoutDelegate get layoutDelegate;
}
