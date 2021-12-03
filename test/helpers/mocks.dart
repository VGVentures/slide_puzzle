import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

class MockPuzzleTheme extends Mock implements PuzzleTheme {}

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}

class MockThemeState extends Mock implements ThemeState {}

class MockPuzzleBloc extends MockBloc<PuzzleEvent, PuzzleState>
    implements PuzzleBloc {}

class MockPuzzleState extends Mock implements PuzzleState {}

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

class MockTimerState extends Mock implements TimerState {}

class MockPuzzle extends Mock implements Puzzle {}

class MockTile extends Mock implements Tile {}

class MockPuzzleLayoutDelegate extends Mock implements PuzzleLayoutDelegate {}
