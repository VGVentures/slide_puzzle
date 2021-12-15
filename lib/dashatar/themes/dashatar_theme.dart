import 'dart:ui';

import 'package:path/path.dart' as p;
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

/// {@template dashatar_theme}
/// The dashatar puzzle theme.
/// {@endtemplate}
abstract class DashatarTheme extends PuzzleTheme {
  /// {@macro dashatar_theme}
  const DashatarTheme() : super();

  @override
  String get name => 'Dashatar';

  @override
  bool get hasTimer => true;

  @override
  bool get hasCountdown => true;

  @override
  Color get hoverColor => PuzzleColors.black2;

  @override
  Color get pressedColor => PuzzleColors.white2;

  @override
  Color get logoColor => PuzzleColors.white;

  @override
  Color get menuActiveColor => PuzzleColors.white;

  @override
  Color get menuUnderlineColor => PuzzleColors.white;

  @override
  PuzzleLayoutDelegate get layoutDelegate =>
      const DashatarPuzzleLayoutDelegate();

  /// The path to the directory with dash assets for all puzzle tiles.
  String get dashAssetsDirectory;

  /// The path to the dash asset for the given [tile].
  ///
  /// The puzzle consists of 15 Dash tiles which correct board positions
  /// are as follows:
  ///
  ///  1   2   3   4
  ///  5   6   7   8
  ///  9  10  11  12
  /// 13  14  15
  ///
  /// The dash asset for the i-th tile may be found in the file i.png.
  String dashAssetForTile(Tile tile) =>
      p.join(dashAssetsDirectory, '${tile.value.toString()}.png');

  @override
  List<Object?> get props => [
        name,
        hasTimer,
        hasCountdown,
        backgroundColor,
        defaultColor,
        buttonColor,
        hoverColor,
        pressedColor,
        logoColor,
        menuActiveColor,
        menuUnderlineColor,
        menuInactiveColor,
        layoutDelegate,
        dashAssetsDirectory
      ];
}
