import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// The url to share for this Flutter Puzzle challenge.
const _shareUrl = 'https://flutterhack.devpost.com/';

/// {@template dashatar_twitter_button}
/// Displays a button that shares the Flutter Puzzle challenge
/// on Twitter when tapped.
/// {@endtemplate}
class DashatarTwitterButton extends StatelessWidget {
  /// {@macro dashatar_twitter_button}
  const DashatarTwitterButton({Key? key}) : super(key: key);

  String _twitterShareUrl(BuildContext context) {
    final shareText = context.l10n.dashatarSuccessShareText;
    final encodedShareText = Uri.encodeComponent(shareText);
    return 'https://twitter.com/intent/tweet?url=$_shareUrl&text=$encodedShareText';
  }

  @override
  Widget build(BuildContext context) {
    return _DashatarShareButton(
      title: 'Twitter',
      icon: Image.asset(
        'assets/images/twitter_icon.png',
        width: 13.13,
        height: 10.67,
      ),
      color: const Color(0xFF13B9FD),
      onPressed: () => openLink(_twitterShareUrl(context)),
    );
  }
}

/// {@template dashatar_facebook_button}
/// Displays a button that shares the Flutter Puzzle challenge
/// on Facebook when tapped.
/// {@endtemplate}
class DashatarFacebookButton extends StatelessWidget {
  /// {@macro dashatar_facebook_button}
  const DashatarFacebookButton({Key? key}) : super(key: key);

  String _facebookShareUrl(BuildContext context) {
    final shareText = context.l10n.dashatarSuccessShareText;
    final encodedShareText = Uri.encodeComponent(shareText);
    return 'https://www.facebook.com/sharer.php?u=$_shareUrl&quote=$encodedShareText';
  }

  @override
  Widget build(BuildContext context) {
    return _DashatarShareButton(
      title: 'Facebook',
      icon: Image.asset(
        'assets/images/facebook_icon.png',
        width: 6.56,
        height: 13.13,
      ),
      color: const Color(0xFF0468D7),
      onPressed: () => openLink(_facebookShareUrl(context)),
    );
  }
}

class _DashatarShareButton extends StatelessWidget {
  const _DashatarShareButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// The title of this button.
  final String title;

  /// The icon of this button.
  final Widget icon;

  /// The color of this button.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          backgroundColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            const Gap(12),
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                alignment: Alignment.center,
                width: 32,
                height: 32,
                color: color,
                child: icon,
              ),
            ),
            const Gap(10),
            Text(
              title,
              style: PuzzleTextStyle.headline5.copyWith(
                color: color,
              ),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
