import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

/// {@template dashatar_share_dialog}
/// Displays a Dashatar share dialog with a score of the completed puzzle
/// and an option to share the score using Twitter or Facebook.
/// {@endtemplate}
class DashatarShareDialog extends StatefulWidget {
  /// {@macro dashatar_share_dialog}
  const DashatarShareDialog({Key? key}) : super(key: key);

  @override
  State<DashatarShareDialog> createState() => _DashatarShareDialogState();
}

class _DashatarShareDialogState extends State<DashatarShareDialog>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    Future.delayed(const Duration(milliseconds: 140), () {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final padding = currentSize == ResponsiveLayoutSize.large
            ? const EdgeInsets.fromLTRB(68, 82, 68, 73)
            : (currentSize == ResponsiveLayoutSize.medium
                ? const EdgeInsets.fromLTRB(48, 54, 48, 53)
                : const EdgeInsets.fromLTRB(20, 99, 20, 76));

        final closeIconOffset = currentSize == ResponsiveLayoutSize.large
            ? const Offset(44, 37)
            : (currentSize == ResponsiveLayoutSize.medium
                ? const Offset(25, 28)
                : const Offset(17, 63));

        final crossAxisAlignment = currentSize == ResponsiveLayoutSize.large
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center;

        return Stack(
          key: const Key('dashatar_share_dialog'),
          children: [
            SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    child: Padding(
                      padding: padding,
                      child: DashatarShareDialogAnimatedBuilder(
                        animation: controller,
                        builder: (context, child, animation) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: crossAxisAlignment,
                            children: [
                              SlideTransition(
                                position: animation.scoreOffset,
                                child: Opacity(
                                  opacity: animation.scoreOpacity.value,
                                  child: const DashatarScore(),
                                ),
                              ),
                              const ResponsiveGap(
                                small: 40,
                                medium: 40,
                                large: 80,
                              ),
                              DashatarShareYourScore(
                                animation: animation,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              right: closeIconOffset.dx,
              top: closeIconOffset.dy,
              child: IconButton(
                key: const Key('dashatar_share_dialog_close_button'),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconSize: 18,
                icon: const Icon(
                  Icons.close,
                  color: PuzzleColors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        );
      },
    );
  }
}
