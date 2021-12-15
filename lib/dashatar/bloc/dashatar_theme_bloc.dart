import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

part 'dashatar_theme_event.dart';
part 'dashatar_theme_state.dart';

/// {@template dashatar_theme_bloc}
/// Bloc responsible for the currently selected [DashatarTheme].
/// {@endtemplate}
class DashatarThemeBloc extends Bloc<DashatarThemeEvent, DashatarThemeState> {
  /// {@macro dashatar_theme_bloc}
  DashatarThemeBloc({required this.themes})
      : super(const DashatarThemeState()) {
    on<DashatarThemeChanged>(_onDashatarThemeChanged);
  }

  /// List of available [DashatarTheme]s to choose from.
  final List<DashatarTheme> themes;

  void _onDashatarThemeChanged(
    DashatarThemeChanged event,
    Emitter<DashatarThemeState> emit,
  ) {
    emit(DashatarThemeState(theme: themes[event.themeIndex]));
  }
}
