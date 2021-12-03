import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

class MockPuzzleTheme extends Mock implements PuzzleTheme {}

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}

class MockThemeState extends Mock implements ThemeState {}

class MockPuzzleBloc extends MockBloc<PuzzleEvent, PuzzleState>
    implements PuzzleBloc {}
