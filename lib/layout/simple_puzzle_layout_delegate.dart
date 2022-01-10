import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

/// {@template simple_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [SimpleTheme].
/// {@endtemplate}
class SimplePuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro simple_puzzle_layout_delegate}
  const SimplePuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => SimpleStartSection(state: state),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const SimplePuzzleShuffleButton(),
          medium: (_, child) => const SimplePuzzleShuffleButton(),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
      ],
    );
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: ResponsiveLayoutBuilder(
        small: (_, __) => SizedBox(
          width: 184,
          height: 118,
          child: Image.asset(
            'assets/images/simple_dash_small.png',
            key: const Key('simple_puzzle_dash_small'),
          ),
        ),
        medium: (_, __) => SizedBox(
          width: 380.44,
          height: 214,
          child: Image.asset(
            'assets/images/simple_dash_medium.png',
            key: const Key('simple_puzzle_dash_medium'),
          ),
        ),
        large: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 53),
          child: SizedBox(
            width: 568.99,
            height: 320,
            child: Image.asset(
              'assets/images/simple_dash_large.png',
              key: const Key('simple_puzzle_dash_large'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
          large: 96,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => SizedBox.square(
            dimension: _BoardSize.small,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_small'),
              size: size,
              tiles: tiles,
            ),
          ),
          medium: (_, __) => SizedBox.square(
            dimension: _BoardSize.medium,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_medium'),
              size: size,
              tiles: tiles,
            ),
          ),
          large: (_, __) => SizedBox.square(
            dimension: _BoardSize.large,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_large'),
              size: size,
              tiles: tiles,
            ),
          ),
        ),
        const ResponsiveGap(
          large: 96,
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(
    Tile tile,
    PuzzleState state,
    Animation<double>? transitionAnimation,
    Animation<double>? pulseAnimation,
  ) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => SimplePuzzleTile(
        key: Key('simple_puzzle_tile_${tile.value}_small'),
        tile: tile,
        tileFontSize: _TileFontSize.small,
        tileSize: _TileSize.small,
        transition: transitionAnimation,
        pulseAnimation: pulseAnimation,
        state: state,
      ),
      medium: (_, __) => SimplePuzzleTile(
        key: Key('simple_puzzle_tile_${tile.value}_medium'),
        tile: tile,
        tileFontSize: _TileFontSize.medium,
        tileSize: _TileSize.medium,
        transition: transitionAnimation,
        pulseAnimation: pulseAnimation,
        state: state,
      ),
      large: (_, __) => SimplePuzzleTile(
        key: Key('simple_puzzle_tile_${tile.value}_large'),
        tile: tile,
        tileFontSize: _TileFontSize.large,
        tileSize: _TileSize.large,
        transition: transitionAnimation,
        pulseAnimation: pulseAnimation,
        state: state,
      ),
    );
  }

  @override
  List<Object?> get props => [];

  @override
  Widget timerBuilder(int maxValue, int elapsed) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
          large: 96,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => SimplePuzzleTimer(
            key: const Key('simple_puzzle_timer_small'),
            elapsed: elapsed,
            maxValue: maxValue,
            width: _BoardSize.small,
          ),
          medium: (_, __) => SimplePuzzleTimer(
            key: const Key('simple_puzzle_timer_medium'),
            elapsed: elapsed,
            maxValue: maxValue,
            width: _BoardSize.medium,
          ),
          large: (_, __) => SimplePuzzleTimer(
            key: const Key('simple_puzzle_timer_large'),
            elapsed: elapsed,
            maxValue: maxValue,
            width: _BoardSize.large,
          ),
        ),
        const ResponsiveGap(
          large: 96,
        ),
      ],
    );
  }
}

/// {@template simple_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
@visibleForTesting
class SimpleStartSection extends StatelessWidget {
  /// {@macro simple_start_section}
  const SimpleStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 83,
          large: 151,
        ),
        const PuzzleName(),
        const ResponsiveGap(large: 16),
        SimplePuzzleTitle(
          status: state.puzzleStatus,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        PuzzleStatLine(
          numberOfMoves: state.numberOfMoves,
          numberOfRowsCleared: state.puzzle.rowsCleared,
        ),
        const ResponsiveGap(large: 32),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => const SimplePuzzleShuffleButton(),
        ),
      ],
    );
  }
}

/// {@template simple_puzzle_title}
/// Displays the title of the puzzle based on [status].
///
/// Shows the success state when the puzzle is completed,
/// otherwise defaults to the Puzzle Challenge title.
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleTitle extends StatelessWidget {
  /// {@macro simple_puzzle_title}
  const SimplePuzzleTitle({
    Key? key,
    required this.status,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleStatus status;

  @override
  Widget build(BuildContext context) {
    return PuzzleTitle(
      title: status == PuzzleStatus.complete
          ? context.l10n.puzzleCompleted
          : context.l10n.puzzleChallengeTitle,
    );
  }
}

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}

/// {@template simple_puzzle_board}
/// Display the board of the puzzle in a [size]x[size] layout
/// filled with [tiles].
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleBoard extends StatelessWidget {
  /// {@macro simple_puzzle_board}
  const SimplePuzzleBoard({
    Key? key,
    required this.size,
    required this.tiles,
  }) : super(key: key);

  /// The size of the board.
  final int size;

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: size,
      children: tiles,
    );
  }
}

abstract class _TileFontSize {
  static double small = 28;
  static double medium = 32;
  static double large = 40;
}

abstract class _TileSize {
  static Size small = const Size.square(36);
  static Size medium = const Size.square(50);
  static Size large = const Size.square(60);
}

/// {@template simple_puzzle_tile}
/// Displays the puzzle tile associated with [tile] and
/// the font size of [tileFontSize] based on the puzzle [state].
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleTile extends StatelessWidget {
  /// {@macro simple_puzzle_tile}
  const SimplePuzzleTile({
    Key? key,
    required this.tile,
    required this.tileFontSize,
    required this.state,
    required this.tileSize,
    required this.transition,
    required this.pulseAnimation,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  /// The size of the tile box
  final Size tileSize;

  /// The state of the puzzle.
  final PuzzleState state;

  /// The transition animation.
  final Animation<double>? transition;

  /// A pulsing animation constantly going [0-1] and [1-0].
  final Animation<double>? pulseAnimation;

  /// Get the previous tile that was in this spot.
  Tile? getLastTile() {
    late Tile lastTile;
    try {
      lastTile = state.puzzle.getTileLastAt(tile.currentPosition);
    } catch (e) {
      if (tile.lastPosition == null) {
        return null;
      } else if (tile.value != -1) {
        if (state.tileMovementStatus == TileMovementStatus.rowCleared) {
          // can return special row cleared tile here (these are the last
          // tiles of the top row.)
        }
        return state.puzzle.getTileWithValue(-1);
      } else {
        return null;
      }
    }

    if (lastTile.value == tile.value) {
      if (tile.lastPosition != null && tile.value != -1) {
        return state.puzzle.getTileWithValue(-1);
      }
      return null;
    }
    return lastTile;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final inNextSpot = tile.currentPosition ==
        Position(x: state.puzzle.getNextTile()?.correctPosition.x ?? 0, y: 1);

    final lastTile = getLastTile();

    final tileColor = _getTileColor(tile, theme);
    final lastTileColor =
        lastTile == null ? null : _getTileColor(lastTile, theme);

    late Offset moveDirection;
    if (lastTile != null && tile.lastPosition != null) {
      if (tile.currentPosition.x > tile.lastPosition!.x) {
        moveDirection = const Offset(-1, 0);
      } else if (tile.currentPosition.x < tile.lastPosition!.x) {
        moveDirection = const Offset(1, 0);
      } else if (tile.currentPosition.y > tile.lastPosition!.y) {
        moveDirection = const Offset(0, -1);
      } else if (tile.currentPosition.y < tile.lastPosition!.y) {
        moveDirection = const Offset(0, 1);
      }
    } else {
      moveDirection = Offset.zero;
    }

    return GestureDetector(
      onTap: state.puzzleStatus == PuzzleStatus.incomplete
          ? () => context.read<PuzzleBloc>().add(TileTapped(tile))
          : null,
      child: CustomPaint(
        size: tileSize,
        painter: _SimpleTilePainter(
          tileFontSize: tileFontSize,
          currentTile: tile,
          currentTileColor: tileColor,
          lastTileColor: lastTileColor,
          lastTile: lastTile,
          moveDirection: moveDirection,
          isInNextSpot: inNextSpot && pulseAnimation != null,
          nextSpotAnimation: pulseAnimation,
          transition: transition,
          nextSpotColor: theme.nextTileColor,
        ),
      ),
    );
  }

  Color _getTileColor(Tile tile, PuzzleTheme theme) {
    if (tile.isWhitespace) {
      return const Color(0xFFFFFFFF);
    }
    final nextTile = state.puzzle.getNextTile();
    if (nextTile != null) {
      if (tile.value <= nextTile.value &&
          tile.currentPosition.x == tile.correctPosition.x &&
          tile.correctPosition.y == state.puzzle.rowsCleared + 1 &&
          tile.currentPosition.y == 1) {
        if (tile.currentPosition.x >= state.puzzle.getDimension() - 1) {
          return theme.semiLockedTileColor;
        }
        return theme.lockedTileColor;
      }
      if (tile.value == nextTile.value) {
        return theme.nextTileColor;
      }
    }
    if (tile.value == state.lastTappedTile?.value) {
      return theme.pressedColor;
    } else {
      return theme.defaultColor;
    }
  }
}

class _SimpleTilePainter extends CustomPainter {
  /// Construct a tile view, that animates based on the given [transition]
  /// and [lastTile] values, in the direction given by the sign of x and y
  /// in [moveDirection].
  _SimpleTilePainter({
    required this.currentTile,
    required this.lastTile,
    required this.moveDirection,
    required this.transition,
    required this.currentTileColor,
    required this.lastTileColor,
    required this.isInNextSpot,
    required this.nextSpotAnimation,
    required this.nextSpotColor,
    required this.tileFontSize,
  })  : assert(
          lastTile == null || lastTileColor != null,
          'If last tile is not-null, a color must be provided',
        ),
        assert(
          !isInNextSpot || (nextSpotAnimation != null && nextSpotColor != null),
          'If this tile is in the next spot, an animation and color'
          ' must be provided.',
        ),
        super(repaint: Listenable.merge([transition, nextSpotAnimation]));

  final Color currentTileColor;
  final Color? lastTileColor;
  final Tile currentTile;
  final Tile? lastTile;
  final Offset moveDirection;
  final Animation<double>? transition;
  final bool isInNextSpot;
  final Animation<double>? nextSpotAnimation;
  final Color? nextSpotColor;
  final double tileFontSize;

  @override
  void paint(Canvas canvas, Size size) {
    var currentOffset = Offset.zero;
    if (transition != null && !currentTile.isWhitespace) {
      final dx = (1 - transition!.value) * moveDirection.dx * size.width;
      final dy = (1 - transition!.value) * moveDirection.dy * size.height;
      currentOffset = Offset(dx, dy);
    }

    var lastOffset = Offset.zero;
    if (transition != null && !(lastTile?.isWhitespace ?? true)) {
      final dx = transition!.value * moveDirection.dx * size.width;
      final dy = transition!.value * moveDirection.dy * size.height;
      lastOffset = Offset(dx, dy);
    }

    if (!isInNextSpot) {
      canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }
    canvas.saveLayer(Rect.largest, Paint());
    if (currentTile.isWhitespace) {
      drawTile(canvas, currentTile, currentTileColor, currentOffset, size);
      if (lastTile != null && transition != null && !transition!.isCompleted) {
        drawTile(canvas, lastTile!, lastTileColor!, lastOffset, size);
      }
    } else if (lastTile != null && lastTile!.isWhitespace) {
      // if (transition != null && !transition!.isCompleted) {
      //   drawTile(canvas, lastTile!, lastTileColor!, lastOffset, size);
      // }
      drawTile(canvas, currentTile, currentTileColor, currentOffset, size);
    } else if (lastTile == null) {
      drawTile(canvas, currentTile, currentTileColor, currentOffset, size);
    } else {
      if (lastTile != null && transition != null && !transition!.isCompleted) {
        drawTile(
          canvas,
          lastTile!,
          lastTileColor!,
          currentOffset.translate(
            -moveDirection.dx * size.width,
            -moveDirection.dy * size.height,
          ),
          size,
        );
      }
      drawTile(canvas, currentTile, currentTileColor, currentOffset, size);
    }

    if (nextSpotAnimation != null && nextSpotColor != null && isInNextSpot) {
      final nextSpotPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7 - 2 * nextSpotAnimation!.value
        ..color = nextSpotColor!;
      final nextSpotBufferPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20
        ..color = const Color(0xFFFFFFFF);
      final nextSpotInnerBufferPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..color = const Color(0xFFFFFFFF);
      canvas
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: size.width / 2 - 2,
            ),
            const Radius.circular(8),
          ),
          nextSpotBufferPaint,
        )
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: size.width / 2 - 10 - 2 * (1 - nextSpotAnimation!.value),
            ),
            const Radius.circular(8),
          ),
          nextSpotInnerBufferPaint,
        )
        ..drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: size.width / 2 - 2 - 6 * nextSpotAnimation!.value,
            ),
            const Radius.circular(8),
          ),
          nextSpotPaint,
        );
    }

    canvas.restore();
  }

  void drawTile(
    Canvas canvas,
    Tile tile,
    Color color,
    Offset offset,
    Size size,
  ) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    final outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20
      ..color = const Color(0xFFFFFFFF);

    canvas
      ..drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCircle(
            center: offset.translate(size.width / 2, size.height / 2),
            radius: size.width / 2,
          ),
          const Radius.circular(8),
        ),
        paint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
          const Radius.circular(8),
        ),
        outlinePaint,
      );

    if (!tile.isWhitespace) {
      final span = TextSpan(
        style: TextStyle(
          color: const Color(0xFFFFFFFF),
          fontSize: tileFontSize,
          fontWeight: FontWeight.bold,
        ),
        text: tile.value.toString(),
      );
      final tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp
        ..layout()
        ..paint(
          canvas,
          offset.translate(
            size.width / 2 - tp.width / 2,
            size.height / 2 - tp.height / 2,
          ),
        );
    }
  }

  @override
  bool shouldRepaint(_SimpleTilePainter oldDelegate) =>
      oldDelegate.currentTile != currentTile ||
      oldDelegate.currentTileColor != currentTileColor ||
      oldDelegate.lastTile != lastTile ||
      oldDelegate.lastTileColor != lastTileColor ||
      oldDelegate.moveDirection != moveDirection ||
      oldDelegate.transition != transition ||
      oldDelegate.tileFontSize != tileFontSize;

  @override
  bool shouldRebuildSemantics(_SimpleTilePainter oldDelegate) => false;
}

/// {@template puzzle_shuffle_button}
/// Displays the button to shuffle the puzzle.
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleShuffleButton extends StatelessWidget {
  /// {@macro puzzle_shuffle_button}
  const SimplePuzzleShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PuzzleButton(
      textColor: PuzzleColors.primary0,
      backgroundColor: PuzzleColors.primary6,
      onPressed: () => context.read<PuzzleBloc>().add(const PuzzleReset()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/shuffle_icon.png',
            width: 17,
            height: 17,
          ),
          const Gap(10),
          Text(context.l10n.puzzleRestart),
        ],
      ),
    );
  }
}

/// Basic bar that shrinks as timer approaches max value.
class SimplePuzzleTimer extends StatelessWidget {
  /// Create a simple timer
  const SimplePuzzleTimer({
    required this.elapsed,
    required this.maxValue,
    required this.width,
    Key? key,
  }) : super(key: key);

  /// The value elapsed on the timer from [0, inf].
  final int elapsed;

  /// The value on the timer representing done.
  final int maxValue;

  /// Width to display the timer in.
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        key: key,
        decoration: BoxDecoration(
          color: theme.timerBackground,
          borderRadius: BorderRadius.circular(6),
        ),
        width: width,
        height: 20,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(color: theme.timerForeground),
            width:
                width * (1 - (elapsed.toDouble() / maxValue)).clamp(0.0, 1.0),
            height: 20,
          ),
        ),
      ),
    );
  }
}
