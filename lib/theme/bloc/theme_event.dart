// ignore_for_file: public_member_api_docs

part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged({required this.themeIndex});

  /// The index of the changed theme in [ThemeBloc.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}
