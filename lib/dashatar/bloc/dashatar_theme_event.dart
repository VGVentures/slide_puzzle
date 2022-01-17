// ignore_for_file: public_member_api_docs

part of 'dashatar_theme_bloc.dart';

abstract class DashatarThemeEvent extends Equatable {
  const DashatarThemeEvent();
}

class DashatarThemeChanged extends DashatarThemeEvent {
  const DashatarThemeChanged({required this.themeIndex});

  /// The index of the changed theme in [DashatarThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}
