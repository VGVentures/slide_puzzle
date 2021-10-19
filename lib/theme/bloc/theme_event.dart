// ignore_for_file: public_member_api_docs

part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged({required this.theme});

  final PuzzleTheme theme;

  @override
  List<Object> get props => [theme];
}
