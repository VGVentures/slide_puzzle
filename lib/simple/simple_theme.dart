import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/layout/puzzle_layout_delegate.dart';
import 'package:very_good_slide_puzzle/simple/simple_puzzle_layout_delegate.dart';
import 'package:very_good_slide_puzzle/theme/themes/puzzle_theme.dart';

class SimpleTheme extends PuzzleTheme {
  /// {@macro simple_theme}
  const SimpleTheme() : super();

  @override
  Color get hoverColor => PuzzleColors.primary3;

  @override
  Color get pressedColor => PuzzleColors.primary7;

  @override
  PuzzleLayoutDelegate get layoutDelegate => const SimplePuzzleLayoutDelegate();

  @override
  List<Object?> get props => [
    hoverColor,
    pressedColor,
    layoutDelegate,
  ];
}
