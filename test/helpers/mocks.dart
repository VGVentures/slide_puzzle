import 'package:bloc_test/bloc_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nftpuzzlefun/audio_control/audio_control.dart';
import 'package:nftpuzzlefun/dashatar/dashatar.dart';
import 'package:nftpuzzlefun/helpers/helpers.dart';
import 'package:nftpuzzlefun/layout/layout.dart';
import 'package:nftpuzzlefun/models/models.dart';
import 'package:nftpuzzlefun/puzzle/puzzle.dart';
import 'package:nftpuzzlefun/theme/theme.dart';
import 'package:nftpuzzlefun/timer/timer.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class MockPuzzleTheme extends Mock implements PuzzleTheme {}

class MockDashatarTheme extends Mock implements DashatarTheme {}

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}

class MockDashatarThemeBloc
    extends MockBloc<DashatarThemeEvent, DashatarThemeState>
    implements DashatarThemeBloc {}

class MockDashatarPuzzleBloc
    extends MockBloc<DashatarPuzzleEvent, DashatarPuzzleState>
    implements DashatarPuzzleBloc {}

class MockDashatarPuzzleState extends Mock implements DashatarPuzzleState {}

class MockPuzzleBloc extends MockBloc<PuzzleEvent, PuzzleState>
    implements PuzzleBloc {}

class MockPuzzleEvent extends Mock implements PuzzleEvent {}

class MockPuzzleState extends Mock implements PuzzleState {}

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

class MockTimerState extends Mock implements TimerState {}

class MockPuzzle extends Mock implements Puzzle {}

class MockTile extends Mock implements Tile {}

class MockPuzzleLayoutDelegate extends Mock implements PuzzleLayoutDelegate {}

class MockTicker extends Mock implements Ticker {}

class MockUrlLauncher extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

class MockAudioPlayer extends Mock implements AudioPlayer {}

class MockPlatformHelper extends Mock implements PlatformHelper {}

class MockAudioControlBloc
    extends MockBloc<AudioControlEvent, AudioControlState>
    implements AudioControlBloc {}
