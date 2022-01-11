// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

/// The animation builder of [DashatarShareDialog].
class DashatarShareDialogAnimatedBuilder extends StatelessWidget {
  const DashatarShareDialogAnimatedBuilder({
    Key? key,
    required this.builder,
    required this.animation,
    this.child,
  }) : super(key: key);

  final MyTransitionBuilder builder;
  final Listenable animation;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return builder(
          context,
          child,
          DashatarShareDialogEnterAnimation(animation as AnimationController),
        );
      },
      child: child,
    );
  }
}

typedef MyTransitionBuilder = Widget Function(
  BuildContext context,
  Widget? child,
  DashatarShareDialogEnterAnimation animation,
);

class DashatarShareDialogEnterAnimation {
  DashatarShareDialogEnterAnimation(this.controller)
      : scoreOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.6, curve: Curves.easeOut),
          ),
        ),
        scoreOffset = Tween<Offset>(
          begin: const Offset(-0.3, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.6, curve: Curves.easeOut),
          ),
        ),
        shareYourScoreOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.25, 0.80, curve: Curves.easeOut),
          ),
        ),
        shareYourScoreOffset = Tween<Offset>(
          begin: const Offset(-0.065, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.25, 0.80, curve: Curves.easeOut),
          ),
        ),
        socialButtonsOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.42, 1, curve: Curves.easeOut),
          ),
        ),
        socialButtonsOffset = Tween<Offset>(
          begin: const Offset(-0.045, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.42, 1, curve: Curves.easeOut),
          ),
        );

  final AnimationController controller;
  final Animation<double> scoreOpacity;
  final Animation<Offset> scoreOffset;
  final Animation<double> shareYourScoreOpacity;
  final Animation<Offset> shareYourScoreOffset;
  final Animation<double> socialButtonsOpacity;
  final Animation<Offset> socialButtonsOffset;
}
