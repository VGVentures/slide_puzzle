// ignore_for_file: public_member_api_docs

part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({this.theme = const SimpleTheme()});

  final PuzzleTheme theme;

  @override
  List<Object> get props => [theme];
}
