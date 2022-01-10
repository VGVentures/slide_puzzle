import 'dart:ui';

import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/theme/themes/themes.dart';

/// {@template simple_theme}
/// The simple puzzle theme.
/// {@endtemplate}
class SimpleTheme extends PuzzleTheme {
  /// {@macro simple_theme}
  const SimpleTheme() : super();

  @override
  String get name => 'Simple';

  @override
  bool get hasTimer => true;

  @override
  bool get hasCountdown => false;

  @override
  Color get backgroundColor => PuzzleColors.white;

  @override
  Color get defaultColor => PuzzleColors.primary5;

  @override
  Color get hoverColor => PuzzleColors.primary4;

  @override
  Color get pressedColor => PuzzleColors.primary6;

  @override
  PuzzleLayoutDelegate get layoutDelegate => const SimplePuzzleLayoutDelegate();

  @override
  Color get lockedTileColor => PuzzleColors.primary2;

  @override
  Color get nextTileColor => PuzzleColors.primary7;

  @override
  Color get semiLockedTileColor => PuzzleColors.primary3;

  @override
  Color get clearedTileColor => PuzzleColors.primary9;

  @override
  Color get timerForeground => PuzzleColors.primary8;

  @override
  Color get timerBackground => PuzzleColors.primary2;

  @override
  List<Object?> get props => [
        name,
        hasTimer,
        hasCountdown,
        backgroundColor,
        defaultColor,
        hoverColor,
        pressedColor,
        layoutDelegate,
        lockedTileColor,
        nextTileColor,
        semiLockedTileColor,
        timerForeground,
        timerBackground,
      ];
}
