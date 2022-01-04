// ignore_for_file: public_member_api_docs

part of 'dashatar_theme_bloc.dart';

class DashatarThemeState extends Equatable {
  const DashatarThemeState({
    required this.themes,
    this.theme = const GreenDashatarTheme(),
  });

  /// The list of all available [DashatarTheme]s.
  final List<DashatarTheme> themes;

  /// Currently selected [DashatarTheme].
  final DashatarTheme theme;

  @override
  List<Object> get props => [themes, theme];

  DashatarThemeState copyWith({
    List<DashatarTheme>? themes,
    DashatarTheme? theme,
  }) {
    return DashatarThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
    );
  }
}
