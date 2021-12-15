// ignore_for_file: public_member_api_docs

part of 'dashatar_theme_bloc.dart';

class DashatarThemeState extends Equatable {
  const DashatarThemeState({this.theme = const GreenDashatarTheme()});

  /// Currently selected [DashatarTheme].
  final DashatarTheme theme;

  @override
  List<Object> get props => [theme];
}
