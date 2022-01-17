// ignore_for_file: public_member_api_docs

part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

/// The currently selected theme has changed.
class ThemeChanged extends ThemeEvent {
  const ThemeChanged({required this.themeIndex});

  /// The index of the newly selected theme from [ThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}

/// The theme identified by [PuzzleTheme.name] has been updated
/// and should be replaced in [ThemeState.themes].
///
/// This can happen if the theme named [PuzzleTheme.name] is already
/// present in [ThemeState.themes] but needs to be updated with a new
/// one, e.g. with slightly different colors or options.
class ThemeUpdated extends ThemeEvent {
  const ThemeUpdated({required this.theme});

  /// The theme from [ThemeState.themes] that should be replaced.
  final PuzzleTheme theme;

  @override
  List<Object> get props => [theme];
}
