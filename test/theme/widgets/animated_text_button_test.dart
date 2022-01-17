// ignore_for_file: prefer_const_constructors
// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../helpers/helpers.dart';

const switchKey = Key('switchKey');
const animationDuration = Duration(milliseconds: 1000);
const additionalDelay = Duration(milliseconds: 1);

void main() {
  group('AnimatedTextButton', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpApp(
        AnimatedTextButton(
          onPressed: () {},
          style: ButtonStyle(),
          duration: kThemeAnimationDuration,
          child: SizedBox(
            key: Key('__text__'),
          ),
        ),
      );

      expect(find.byKey(Key('__text__')), findsOneWidget);
    });

    testWidgets(
        'calls onPressed '
        'when tapped', (tester) async {
      var onPressedCalled = false;

      await tester.pumpApp(
        AnimatedTextButton(
          onPressed: () => onPressedCalled = true,
          style: ButtonStyle(),
          duration: kThemeAnimationDuration,
          child: SizedBox(
            key: Key('__text__'),
          ),
        ),
      );

      await tester.tap(find.byType(AnimatedTextButton));

      expect(onPressedCalled, isTrue);
    });

    testWidgets('onEnd is called', (WidgetTester tester) async {
      var called = 0;
      void onEnd() => called++;

      await tester.pumpApp(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Material(
            child: TestAnimatedTextButton(
              onEnd: onEnd,
              switchKey: switchKey,
            ),
          ),
        ),
      );

      final switchFinder = find.byKey(switchKey);

      await tester.tap(switchFinder);
      await tester.pump();

      expect(called, equals(0));
      await tester.pump(animationDuration);
      expect(called, equals(0));
      await tester.pump(additionalDelay);
      expect(called, equals(1));
    });

    testWidgets('style is animated over time', (WidgetTester tester) async {
      await tester.pumpApp(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Material(
            child: TestAnimatedTextButton(
              switchKey: switchKey,
            ),
          ),
        ),
      );

      final state = tester.state(find.byType(TestAnimatedTextButton))
          as RebuildCountingState<TestAnimatedTextButton>;

      final switchFinder = find.byKey(switchKey);
      final textButtonFinder = find.descendant(
        of: find.byType(AnimatedTextButton),
        matching: find.byType(Material),
      );

      expect(state.builds, equals(1));

      await tester.tap(switchFinder);
      expect(state.builds, equals(1));
      await tester.pump();
      expect(
        tester.widget<Material>(textButtonFinder).color,
        equals(Colors.green.shade500),
      );
      expect(state.builds, equals(2));

      await tester.pump(const Duration(milliseconds: 500));
      expect(
        tester.widget<Material>(textButtonFinder).color,
        equals(Color.lerp(Colors.green.shade500, Colors.blue.shade500, 0.5)),
      );
      expect(state.builds, equals(2));

      await tester.pump(const Duration(milliseconds: 1000));
      expect(
        tester.widget<Material>(textButtonFinder).color,
        equals(Colors.blue.shade500),
      );
      expect(state.builds, equals(2));
    });
  });
}

class TestAnimatedTextButton extends StatefulWidget {
  const TestAnimatedTextButton({
    Key? key,
    this.onEnd,
    required this.switchKey,
  }) : super(key: key);

  final VoidCallback? onEnd;
  final Key switchKey;

  @override
  State<TestAnimatedTextButton> createState() => _TestAnimatedTextButtonState();
}

abstract class RebuildCountingState<T extends StatefulWidget> extends State<T> {
  int builds = 0;
}

class _TestAnimatedTextButtonState
    extends RebuildCountingState<TestAnimatedTextButton> {
  bool toggle = false;
  final Widget child = const Placeholder();
  final Duration duration = animationDuration;

  @override
  Widget build(BuildContext context) {
    builds++;

    return Stack(
      children: <Widget>[
        AnimatedTextButton(
          duration: duration,
          onPressed: () {},
          style: !toggle
              ? ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade500),
                )
              : ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade500),
                ),
          onEnd: widget.onEnd,
          child: child,
        ),
        Switch(
          key: widget.switchKey,
          value: toggle,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void onChanged(bool v) {
    setState(() {
      toggle = v;
    });
  }
}
