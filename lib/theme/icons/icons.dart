import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// {@template shuffle_icon}
/// A shuffle icon
/// {@endtemplate}
class ShuffleIcon extends _SvgIcon {
  /// {@macro shuffle_icon}
  const ShuffleIcon({Key? key})
      : super(
          assetName: 'assets/images/shuffle_icon.svg',
          semanticsLabel: 'Shuffle icon',
          key: key,
        );
}

class _SvgIcon extends StatelessWidget {
  const _SvgIcon({
    Key? key,
    required this.assetName,
    required this.semanticsLabel,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  final String assetName;
  final String semanticsLabel;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      fit: fit,
      semanticsLabel: semanticsLabel,
    );
  }
}
