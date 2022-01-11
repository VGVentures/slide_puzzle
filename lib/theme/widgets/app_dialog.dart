import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

/// {@template app_dialog}
/// Displays a full screen dialog on a small display and
/// a fixed-width rounded dialog on a medium and large display.
/// {@endtemplate}
class AppDialog extends StatelessWidget {
  /// {@macro app_dialog}
  const AppDialog({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// The content of this dialog.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => Material(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: child,
        ),
      ),
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final dialogWidth =
            currentSize == ResponsiveLayoutSize.large ? 740.0 : 700.0;

        return Dialog(
          clipBehavior: Clip.hardEdge,
          backgroundColor: PuzzleColors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: SizedBox(
            width: dialogWidth,
            child: child,
          ),
        );
      },
    );
  }
}
