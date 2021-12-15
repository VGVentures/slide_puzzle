import 'dart:ui';

import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

/// {@template green_dashatar_theme}
/// The green dashatar puzzle theme.
/// {@endtemplate}
class GreenDashatarTheme extends DashatarTheme {
  /// {@macro green_dashatar_theme}
  const GreenDashatarTheme() : super();

  @override
  Color get backgroundColor => PuzzleColors.greenPrimary;

  @override
  Color get defaultColor => PuzzleColors.green90;

  @override
  Color get buttonColor => PuzzleColors.green50;

  @override
  Color get menuInactiveColor => PuzzleColors.green50;

  @override
  String get dashAssetsDirectory => 'assets/images/dashatar/green';
}
