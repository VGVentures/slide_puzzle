import 'dart:ui';

import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

/// {@template yellow_dashatar_theme}
/// The yellow dashatar puzzle theme.
/// {@endtemplate}
class YellowDashatarTheme extends DashatarTheme {
  /// {@macro yellow_dashatar_theme}
  const YellowDashatarTheme() : super();

  @override
  Color get backgroundColor => PuzzleColors.yellowPrimary;

  @override
  Color get defaultColor => PuzzleColors.yellow90;

  @override
  Color get buttonColor => PuzzleColors.yellow50;

  @override
  Color get menuInactiveColor => PuzzleColors.yellow50;

  @override
  Color get countdownColor => PuzzleColors.yellow50;

  @override
  String get themeAsset => 'assets/images/dashatar/gallery/yellow.png';

  @override
  String get successThemeAsset => 'assets/images/dashatar/success/yellow.png';

  @override
  String get dashAssetsDirectory => 'assets/images/dashatar/yellow';
}
