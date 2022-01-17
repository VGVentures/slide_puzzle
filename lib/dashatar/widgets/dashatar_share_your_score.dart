import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template dashatar_share_your_score}
/// Displays buttons to share a score of the completed puzzle.
/// {@endtemplate}
class DashatarShareYourScore extends StatelessWidget {
  /// {@macro dashatar_share_your_score}
  const DashatarShareYourScore({
    Key? key,
    required this.animation,
  }) : super(key: key);

  /// The entry animation of this widget.
  final DashatarShareDialogEnterAnimation animation;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final titleTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline4
            : PuzzleTextStyle.headline3;

        final messageTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.bodyXSmall
            : PuzzleTextStyle.bodySmall;

        final titleAndMessageCrossAxisAlignment =
            currentSize == ResponsiveLayoutSize.large
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center;

        final textAlign = currentSize == ResponsiveLayoutSize.large
            ? TextAlign.left
            : TextAlign.center;

        final messageWidth = currentSize == ResponsiveLayoutSize.large
            ? double.infinity
            : (currentSize == ResponsiveLayoutSize.medium ? 434.0 : 307.0);

        final buttonsMainAxisAlignment =
            currentSize == ResponsiveLayoutSize.large
                ? MainAxisAlignment.start
                : MainAxisAlignment.center;

        return Column(
          key: const Key('dashatar_share_your_score'),
          crossAxisAlignment: titleAndMessageCrossAxisAlignment,
          children: [
            SlideTransition(
              position: animation.shareYourScoreOffset,
              child: Opacity(
                opacity: animation.shareYourScoreOpacity.value,
                child: Column(
                  crossAxisAlignment: titleAndMessageCrossAxisAlignment,
                  children: [
                    Text(
                      l10n.dashatarSuccessShareYourScoreTitle,
                      key: const Key('dashatar_share_your_score_title'),
                      textAlign: textAlign,
                      style: titleTextStyle.copyWith(
                        color: PuzzleColors.black,
                      ),
                    ),
                    const Gap(16),
                    SizedBox(
                      width: messageWidth,
                      child: Text(
                        l10n.dashatarSuccessShareYourScoreMessage,
                        key: const Key('dashatar_share_your_score_message'),
                        textAlign: textAlign,
                        style: messageTextStyle.copyWith(
                          color: PuzzleColors.grey1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const ResponsiveGap(
              small: 40,
              medium: 40,
              large: 24,
            ),
            SlideTransition(
              position: animation.socialButtonsOffset,
              child: Opacity(
                opacity: animation.socialButtonsOpacity.value,
                child: Row(
                  mainAxisAlignment: buttonsMainAxisAlignment,
                  children: const [
                    DashatarTwitterButton(),
                    Gap(16),
                    DashatarFacebookButton(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
