import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

/// {@template dashatar_theme_picker}
/// Displays the Dashatar theme picker to choose between
/// [DashatarThemeState.themes].
///
/// By default allows to choose between [BlueDashatarTheme],
/// [GreenDashatarTheme] or [YellowDashatarTheme].
/// {@endtemplate}
class DashatarThemePicker extends StatelessWidget {
  /// {@macro dashatar_theme_picker}
  const DashatarThemePicker({Key? key}) : super(key: key);

  static const _activeThemeNormalSize = 120.0;
  static const _activeThemeSmallSize = 65.0;
  static const _inactiveThemeNormalSize = 96.0;
  static const _inactiveThemeSmallSize = 50.0;

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<DashatarThemeBloc>().state;
    final activeTheme = themeState.theme;

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final isSmallSize = currentSize == ResponsiveLayoutSize.small;
        final activeSize =
            isSmallSize ? _activeThemeSmallSize : _activeThemeNormalSize;
        final inactiveSize =
            isSmallSize ? _inactiveThemeSmallSize : _inactiveThemeNormalSize;

        return SizedBox(
          key: const Key('dashatar_theme_picker'),
          height: activeSize,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              themeState.themes.length,
              (index) {
                final theme = themeState.themes[index];
                final isActiveTheme = theme == activeTheme;
                final padding = index > 0 ? (isSmallSize ? 4.0 : 8.0) : 0.0;
                final size = isActiveTheme ? activeSize : inactiveSize;

                return Padding(
                  padding: EdgeInsets.only(left: padding),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      key: Key('dashatar_theme_picker_$index'),
                      onTap: () {
                        // Update the current Dashatar theme.
                        context
                            .read<DashatarThemeBloc>()
                            .add(DashatarThemeChanged(themeIndex: index));
                      },
                      child: AnimatedContainer(
                        width: size,
                        height: size,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 350),
                        child: Image.asset(
                          theme.themeAsset,
                          fit: BoxFit.fill,
                          semanticLabel: theme.semanticsLabel(context),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
