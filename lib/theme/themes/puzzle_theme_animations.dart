/// Defines durations of animations for the puzzle theme.
abstract class PuzzleThemeAnimationDuration {
  /// The duration of a text style animation.
  /// The animation may happen when a theme is changed.
  static const textStyle = Duration(milliseconds: 530);

  /// The duration of a background color change animation.
  /// The animation may happen when a theme is changed.
  static const backgroundColorChange = Duration(milliseconds: 530);

  /// The duration of a logo change animation.
  /// The animation may happen when a theme is changed.
  static const logoChange = Duration(milliseconds: 530);

  /// The duration of a puzzle tile scale change animation.
  /// The animation may happen when a user hovers over a puzzle tile.
  static const puzzleTileScale = Duration(milliseconds: 230);
}
