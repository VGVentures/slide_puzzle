import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

/// {@template responsive_gap}
/// A wrapper around [Gap] that renders a [small], [medium]
/// or a [large] gap depending on the screen size.
/// {@endtemplate}
class ResponsiveGap extends StatelessWidget {
  /// {@macro responsive_gap}
  const ResponsiveGap({
    Key? key,
    this.small = 0,
    this.medium = 0,
    this.large = 0,
  }) : super(key: key);

  /// A gap rendered on a small layout.
  final double small;

  /// A gap rendered on a medium layout.
  final double medium;

  /// A gap rendered on a large layout.
  final double large;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => Gap(small),
      medium: (_, __) => Gap(medium),
      large: (_, __) => Gap(large),
    );
  }
}
