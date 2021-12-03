import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/typography/text_styles.dart';

/// {@template puzzle_button}
/// Displays the puzzle action button.
/// {@endtemplate}
class PuzzleButton extends StatelessWidget {
  /// {@macro puzzle_button}
  const PuzzleButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  /// The background color of this button.
  final Color? backgroundColor;

  /// The text color of this button.
  final Color? textColor;

  /// Called when this button is tapped.
  final VoidCallback onPressed;

  /// The label of this button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      height: 44,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: textColor,
          backgroundColor: backgroundColor,
          onSurface: backgroundColor,
          textStyle: PuzzleTextStyle.headline5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
