import 'package:flutter/material.dart';

/// {@template animated_text_button}
/// Variant of [TextButton] with an animated [style].
/// {@endtemplate}
class AnimatedTextButton extends ImplicitlyAnimatedWidget {
  /// {@macro animated_text_button}
  const AnimatedTextButton({
    Key? key,
    required this.child,
    required this.style,
    required this.onPressed,
    required Duration duration,
    Curve curve = Curves.linear,
    VoidCallback? onEnd,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  /// Typically the button's label.
  final Widget child;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The target text style of this button, must not be null.
  ///
  /// When this property is changed, the style will
  /// be animated over [duration] time.
  final ButtonStyle style;

  @override
  AnimatedWidgetBaseState<AnimatedTextButton> createState() =>
      _AnimatedTextButtonState();
}

class _AnimatedTextButtonState
    extends AnimatedWidgetBaseState<AnimatedTextButton> {
  ButtonStyleTween? _style;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _style = visitor(
      _style,
      widget.style,
      (dynamic value) => ButtonStyleTween(begin: value as ButtonStyle),
    ) as ButtonStyleTween?;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: _style!.evaluate(animation),
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}

/// The tween for [ButtonStyle].
class ButtonStyleTween extends Tween<ButtonStyle> {
  /// Creates a button style tween.
  ///
  /// The [begin] and [end] properties must be non-null before the tween is
  /// first used, but the arguments can be null if the values are going to be
  /// filled in later.
  ButtonStyleTween({ButtonStyle? begin, ButtonStyle? end})
      : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  ButtonStyle lerp(double t) => ButtonStyle.lerp(begin, end, t)!;
}
