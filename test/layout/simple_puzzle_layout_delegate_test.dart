// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/layout/simple_puzzle_layout_delegate.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../helpers/helpers.dart';

void main() {
  group('SimplePuzzleLayoutDelegate', () {
    late SimplePuzzleLayoutDelegate layoutDelegate;
    late ThemeBloc themeBloc;
    late PuzzleTheme theme;
    late PuzzleState state;

    const themeName = 'Name';

    setUpAll(() {
      final oldComparator = goldenFileComparator as LocalFileComparator;
      final newComparator =
          TolerantComparator(Uri.parse('${oldComparator.basedir}test'));
      expect(oldComparator.basedir, newComparator.basedir);
      goldenFileComparator = newComparator;
    });

    setUp(() {
      layoutDelegate = SimplePuzzleLayoutDelegate();
      themeBloc = MockThemeBloc();
      theme = MockPuzzleTheme();
      state = MockPuzzleState();
      final themeState = MockThemeState();

      when(() => state.puzzleStatus).thenReturn(PuzzleStatus.incomplete);
      when(() => state.numberOfMoves).thenReturn(5);
      when(() => state.numberOfTilesLeft).thenReturn(15);

      when(() => theme.name).thenReturn(themeName);
      when(() => theme.defaultColor).thenReturn(Colors.black);
      when(() => themeState.theme).thenReturn(theme);
      when(() => themeBloc.state).thenReturn(themeState);
    });

    group('startSectionBuilder', () {
      testWidgets(
          'renders SimpleStartSection '
          'on a large display', (tester) async {
        tester.setLargeDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: layoutDelegate.startSectionBuilder(state),
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byWidgetPredicate(
            (widget) => widget is SimpleStartSection && widget.state == state,
          ),
          findsOneWidget,
        );
      });

      testWidgets(
          'renders SimpleStartSection '
          'on a medium display', (tester) async {
        tester.setMediumDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: layoutDelegate.startSectionBuilder(state),
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byWidgetPredicate(
            (widget) => widget is SimpleStartSection && widget.state == state,
          ),
          findsOneWidget,
        );
      });

      testWidgets(
          'renders SimpleStartSection '
          'on a small display', (tester) async {
        tester.setSmallDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: layoutDelegate.startSectionBuilder(state),
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byWidgetPredicate(
            (widget) => widget is SimpleStartSection && widget.state == state,
          ),
          findsOneWidget,
        );
      });
    });

    group('endSectionBuilder', () {
      testWidgets(
          'renders an empty widget '
          'on a large display', (tester) async {
        tester.setLargeDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: layoutDelegate.endSectionBuilder(state),
          ),
          themeBloc: themeBloc,
        );

        expect(find.byType(SizedBox), findsOneWidget);
        expect(find.byType(SimplePuzzleShuffleButton), findsNothing);
      });

      testWidgets(
          'renders SimplePuzzleShuffleButton '
          'on a medium display', (tester) async {
        tester.setMediumDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: layoutDelegate.endSectionBuilder(state),
          ),
          themeBloc: themeBloc,
        );

        expect(find.byType(SimplePuzzleShuffleButton), findsOneWidget);
      });

      testWidgets(
          'renders SimplePuzzleShuffleButton '
          'on a small display', (tester) async {
        tester.setSmallDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: layoutDelegate.endSectionBuilder(state),
          ),
          themeBloc: themeBloc,
        );

        expect(find.byType(SimplePuzzleShuffleButton), findsOneWidget);
      });
    });

    group('backgroundBuilder', () {
      testWidgets(
          'renders a large dash Image '
          'on a large display', (tester) async {
        tester.setLargeDisplaySize();

        await tester.pumpApp(
          Stack(
            children: [
              layoutDelegate.backgroundBuilder(state),
            ],
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byKey(Key('simple_puzzle_dash_large')),
          findsOneWidget,
        );
      });

      testWidgets(
          'renders a medium dash Image '
          'on a medium display', (tester) async {
        tester.setMediumDisplaySize();

        await tester.pumpApp(
          Stack(
            children: [
              layoutDelegate.backgroundBuilder(state),
            ],
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byKey(Key('simple_puzzle_dash_medium')),
          findsOneWidget,
        );
      });

      testWidgets(
          'renders a small dash Image '
          'on a small display', (tester) async {
        tester.setSmallDisplaySize();

        await tester.pumpApp(
          Stack(
            children: [
              layoutDelegate.backgroundBuilder(state),
            ],
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byKey(Key('simple_puzzle_dash_small')),
          findsOneWidget,
        );
      });
    });

    group('boardBuilder', () {
      testWidgets(
          'renders a large puzzle board '
          'on a large display', (tester) async {
        tester.setLargeDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: layoutDelegate.boardBuilder(4, [
              const SizedBox(),
            ]),
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byKey(Key('simple_puzzle_board_large')),
          findsOneWidget,
        );
      });

      testWidgets(
          'renders a medium puzzle board '
          'on a medium display', (tester) async {
        tester.setMediumDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: layoutDelegate.boardBuilder(4, [
              const SizedBox(),
            ]),
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byKey(Key('simple_puzzle_board_medium')),
          findsOneWidget,
        );
      });

      testWidgets(
          'renders a small puzzle board '
          'on a small display', (tester) async {
        tester.setSmallDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: layoutDelegate.boardBuilder(4, [
              const SizedBox(),
            ]),
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byKey(Key('simple_puzzle_board_small')),
          findsOneWidget,
        );
      });
    });

    group('tileBuilder', () {
      late Tile tile;
      const tileValue = 10;

      setUp(() {
        tile = MockTile();
        when(() => tile.value).thenReturn(tileValue);
      });

      testWidgets(
          'renders a large puzzle tile '
          'on a large display', (tester) async {
        tester.setLargeDisplaySize();

        await tester.pumpApp(
          layoutDelegate.tileBuilder(tile, state),
          themeBloc: themeBloc,
        );

        expect(
          find.byKey(Key('simple_puzzle_tile_${tileValue}_large')),
          findsOneWidget,
        );
      });

      testWidgets(
          'renders a medium puzzle tile '
          'on a medium display', (tester) async {
        tester.setMediumDisplaySize();

        await tester.pumpApp(
          layoutDelegate.tileBuilder(tile, state),
          themeBloc: themeBloc,
        );

        expect(
          find.byKey(Key('simple_puzzle_tile_${tileValue}_medium')),
          findsOneWidget,
        );
      });

      testWidgets(
          'renders a small puzzle tile '
          'on a small display', (tester) async {
        tester.setSmallDisplaySize();

        await tester.pumpApp(
          layoutDelegate.tileBuilder(tile, state),
          themeBloc: themeBloc,
        );

        expect(
          find.byKey(Key('simple_puzzle_tile_${tileValue}_small')),
          findsOneWidget,
        );
      });
    });

    group('whitespaceTileBuilder', () {
      testWidgets('renders SizedBox', (tester) async {
        await tester.pumpApp(
          layoutDelegate.whitespaceTileBuilder(),
          themeBloc: themeBloc,
        );

        expect(
          find.byType(SizedBox),
          findsOneWidget,
        );
      });
    });

    group('SimpleStartSection', () {
      testWidgets('renders PuzzleName', (tester) async {
        await tester.pumpApp(
          SingleChildScrollView(
            child: SimpleStartSection(state: state),
          ),
          themeBloc: themeBloc,
        );

        expect(find.byType(PuzzleName), findsOneWidget);
      });

      testWidgets('renders SimplePuzzleTitle', (tester) async {
        when(() => state.puzzleStatus).thenReturn(PuzzleStatus.complete);

        await tester.pumpApp(
          SingleChildScrollView(
            child: SimpleStartSection(state: state),
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is SimplePuzzleTitle &&
                widget.status == state.puzzleStatus,
          ),
          findsOneWidget,
        );
      });

      testWidgets('renders NumberOfMovesAndTilesLeft', (tester) async {
        await tester.pumpApp(
          SingleChildScrollView(
            child: SimpleStartSection(state: state),
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is NumberOfMovesAndTilesLeft &&
                widget.numberOfMoves == state.numberOfMoves &&
                widget.numberOfTilesLeft == state.numberOfTilesLeft,
          ),
          findsOneWidget,
        );
      });

      testWidgets(
          'renders SimplePuzzleShuffleButton '
          'on a large display', (tester) async {
        tester.setLargeDisplaySize();

        await tester.pumpApp(
          SingleChildScrollView(
            child: SimpleStartSection(state: state),
          ),
          themeBloc: themeBloc,
        );

        expect(
          find.byType(SimplePuzzleShuffleButton),
          findsOneWidget,
        );
      });
    });

    group('SimplePuzzleTile', () {
      late Tile tile;
      const tileValue = 10;
      const tileFontSize = 12.0;

      setUp(() {
        tile = MockTile();
        when(() => tile.value).thenReturn(tileValue);
      });

      testWidgets(
          'adds TileTapped '
          'when tapped and '
          'puzzle is incomplete', (tester) async {
        final puzzleBloc = MockPuzzleBloc();
        when(() => state.puzzleStatus).thenReturn(PuzzleStatus.incomplete);
        when(() => puzzleBloc.state).thenReturn(state);

        await tester.pumpApp(
          SimplePuzzleTile(
            tile: tile,
            tileFontSize: tileFontSize,
            state: state,
          ),
          themeBloc: themeBloc,
          puzzleBloc: puzzleBloc,
        );

        await tester.tap(find.byType(SimplePuzzleTile));

        verify(() => puzzleBloc.add(TileTapped(tile))).called(1);
      });

      testWidgets(
          'does not add TileTapped '
          'when tapped and '
          'puzzle is complete', (tester) async {
        final puzzleBloc = MockPuzzleBloc();
        when(() => state.puzzleStatus).thenReturn(PuzzleStatus.complete);
        when(() => puzzleBloc.state).thenReturn(state);

        await tester.pumpApp(
          SimplePuzzleTile(
            tile: tile,
            tileFontSize: tileFontSize,
            state: state,
          ),
          themeBloc: themeBloc,
          puzzleBloc: puzzleBloc,
        );

        await tester.tap(find.byType(SimplePuzzleTile));

        verifyNever(() => puzzleBloc.add(TileTapped(tile)));
      });

      group('matches golden file', () {
        setUp(() {
          when(() => theme.defaultColor).thenReturn(PuzzleColors.primary5);
          when(() => theme.hoverColor).thenReturn(PuzzleColors.primary3);
          when(() => theme.pressedColor).thenReturn(PuzzleColors.primary7);
        });

        testWidgets('given default state', (tester) async {
          await tester.pumpApp(
            SimplePuzzleTile(
              tile: tile,
              tileFontSize: tileFontSize,
              state: state,
            ),
            themeBloc: themeBloc,
          );

          await expectLater(
            find.byType(SimplePuzzleTile),
            matchesGoldenFile('goldens/simple_puzzle_tile_default.png'),
          );
        });

        testWidgets('given tapped state', (tester) async {
          when(() => state.lastTappedTile).thenReturn(tile);

          await tester.pumpApp(
            SimplePuzzleTile(
              tile: tile,
              tileFontSize: tileFontSize,
              state: state,
            ),
            themeBloc: themeBloc,
          );

          await expectLater(
            find.byType(SimplePuzzleTile),
            matchesGoldenFile('goldens/simple_puzzle_tile_tapped.png'),
          );
        });

        testWidgets('given hover state', (tester) async {
          await tester.pumpApp(
            SimplePuzzleTile(
              tile: tile,
              tileFontSize: tileFontSize,
              state: state,
            ),
            themeBloc: themeBloc,
          );

          final gesture =
              await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await gesture.moveTo(tester.getCenter(find.byType(SimplePuzzleTile)));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(SimplePuzzleTile),
            matchesGoldenFile('goldens/simple_puzzle_tile_hover.png'),
          );
        });
      });
    });

    group('SimplePuzzleShuffleButton', () {
      testWidgets('adds PuzzleReset on pressed', (tester) async {
        final puzzleBloc = MockPuzzleBloc();

        await tester.pumpApp(
          SimplePuzzleShuffleButton(),
          themeBloc: themeBloc,
          puzzleBloc: puzzleBloc,
        );

        await tester.tap(find.byType(SimplePuzzleShuffleButton));

        verify(() => puzzleBloc.add(PuzzleReset())).called(1);
      });
    });

    test('supports value equality', () {
      expect(
        SimplePuzzleLayoutDelegate(),
        equals(SimplePuzzleLayoutDelegate()),
      );
    });
  });
}
