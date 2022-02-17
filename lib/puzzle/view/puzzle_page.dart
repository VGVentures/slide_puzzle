import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:nftpuzzlefun/audio_control/audio_control.dart';
import 'package:nftpuzzlefun/dashatar/dashatar.dart';
import 'package:nftpuzzlefun/dashatar/widgets/collection_chooser.dart';
import 'package:nftpuzzlefun/l10n/l10n.dart';
import 'package:nftpuzzlefun/layout/layout.dart';
import 'package:nftpuzzlefun/models/models.dart';
import 'package:nftpuzzlefun/puzzle/puzzle.dart';
// import 'package:nftpuzzlefun/simple/simple.dart';
import 'package:nftpuzzlefun/theme/theme.dart';
import 'package:nftpuzzlefun/timer/timer.dart';
import 'package:nftpuzzlefun/typography/typography.dart';
import 'package:opensea_repository/opensea_repository.dart';

// import '../../collections/collections_theme.dart';
import '../../dashatar/bloc/collections_bloc.dart';
import '../../helpers/modal_helper.dart';

/// {@template puzzle_page}
/// The root page of the puzzle UI.
///
/// Builds the puzzle based on the current [PuzzleTheme]
/// from [ThemeBloc].
/// {@endtemplate}
class PuzzlePage extends StatelessWidget {
  /// {@macro puzzle_page}
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DashatarThemeBloc(
            themes: const [
              BlueDashatarTheme(),
              GreenDashatarTheme(),
              YellowDashatarTheme()
            ],
          ),
        ),
        BlocProvider(
          create: (_) => DashatarPuzzleBloc(
            secondsToBegin: 3,
            ticker: const Ticker(),
          ),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(
            initialThemes: [
              context.read<DashatarThemeBloc>().state.theme,
            ],
          ),
        ),
        BlocProvider(
          create: (_) => TimerBloc(
            ticker: const Ticker(),
          ),
        ),
        BlocProvider(
          create: (_) => AudioControlBloc(),
        ),
        BlocProvider(
          create: (_) => CollectionsBloc(
            artworkRepository: ArtworkRepository(),
          )..add(const CollectionsSubscriptionRequested()),
        ),
        BlocProvider(
          create: (context) => ArtworkBloc(
            artworkRepository: ArtworkRepository(),
            // selectedCollection:
            //     context.read<CollectionsBloc>().state.selectedCollection,
          )..add(ArtworkSubscriptionRequested(
              collectionSlug:
                  context.read<CollectionsBloc>().state.selectedCollection)),
        ),
      ],
      child: const PuzzleView(),
    );
  }
}

/// {@template puzzle_view}
/// Displays the content for the [PuzzlePage].
/// {@endtemplate}
class PuzzleView extends StatelessWidget {
  /// {@macro puzzle_view}
  const PuzzleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    // final artworks = context
    //     .select((ArtworkBloc artworksbloc) => artworksbloc.state.artworks);
    // final artwork =
    //     context.select((ArtworkBloc artworkbloc) => artworkbloc.state.artwork);

    final artworkState =
        context.select((ArtworkBloc bloc) => bloc.state.status);
    final collectionsState =
        context.select((CollectionsBloc bloc) => bloc.state.status);

    final isLoadedArtwork = artworkState == ArtworkStatus.success;
    final isLoadedCollections = collectionsState == CollectionsStatus.success;
    if (isLoadedArtwork == false || isLoadedCollections == false) {
      return Scaffold(
        body: Container(
          // TODO: This color should come from theme but theme isn't
          //  available yet? Maybe make this part of the splash screen somehow
          color: Colors.blue,
          child: const Align(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
              backgroundColor: Colors.green,
            ),
          ),
        ),
      );
    }

    /// Shuffle only if the current theme is Simple.
    // final shufflePuzzle = theme is SimpleTheme;
    // const shufflePuzzle = 0; // deprecated

    return Scaffold(
      body: AnimatedContainer(
        duration: PuzzleThemeAnimationDuration.backgroundColorChange,
        decoration: BoxDecoration(color: theme.backgroundColor),
        child: BlocListener<DashatarThemeBloc, DashatarThemeState>(
          listener: (context, state) {
            final dashatarTheme = context.read<DashatarThemeBloc>().state.theme;
            context.read<ThemeBloc>().add(ThemeUpdated(theme: dashatarTheme));
          },
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TimerBloc(
                  ticker: const Ticker(),
                ),
              ),
              BlocProvider(
                create: (context) => PuzzleBloc(4)
                  ..add(
                    const PuzzleInitialized(
                      shufflePuzzle: false,
                    ),
                  ),
              ),
            ],
            child: const _Puzzle(
              key: Key('puzzle_view_puzzle'),
            ),
          ),
        ),
      ),
    );
  }
}

class _Puzzle extends StatelessWidget {
  const _Puzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    // final artworks = context.select((ArtworkBloc bloc) => bloc.state.artworks);
    // final artwork = context.select((ArtworkBloc bloc) => bloc.state.artwork);
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    // final artworkState =
    // context.select((ArtworkBloc bloc) => bloc.state.status);
    // final collectionsState =
    // context.select((CollectionsBloc bloc) => bloc.state.status);
    //
    // final isLoadedArtwork = artworkState == ArtworkStatus.success;
    // final isLoadedCollections = collectionsState == CollectionsStatus.success;
    // if (isLoadedArtwork == false || isLoadedCollections == false) {
    //   return const CircularProgressIndicator();
    // }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: const [
                    PuzzleHeader(),
                    PuzzleSections(),
                  ],
                ),
              ),
            ),
            theme.layoutDelegate.backgroundBuilder(state),
          ],
        );
      },
    );
  }
}

/// {@template puzzle_header}
/// Displays the header of the puzzle.
/// {@endtemplate}
@visibleForTesting
class PuzzleHeader extends StatelessWidget {
  /// {@macro puzzle_header}
  const PuzzleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final artworkState =
    // context.select((ArtworkBloc bloc) => bloc.state.status);
    // final collectionsState =
    // context.select((CollectionsBloc bloc) => bloc.state.status);
    //
    // final isLoadedArtwork = artworkState == ArtworkStatus.success;
    // final isLoadedCollections = collectionsState == CollectionsStatus.success;
    // if (isLoadedArtwork == false || isLoadedCollections == false) {
    //   return const CircularProgressIndicator();
    // }

    return SizedBox(
      height: 96,
      child: ResponsiveLayoutBuilder(
        small: (context, child) => Stack(
          children: [
            const Align(
              child: PuzzleLogo(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 34),
                child: AudioControl(key: audioControlKey),
              ),
            ),
          ],
        ),
        medium: (context, child) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              PuzzleLogo(),
              PuzzleMenu(),
            ],
          ),
        ),
        large: (context, child) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              PuzzleLogo(),
              PuzzleMenu(),
            ],
          ),
        ),
      ),
    );
  }
}

/// {@template puzzle_logo}
/// Displays the logo of the puzzle.
/// {@endtemplate}
@visibleForTesting
class PuzzleLogo extends StatelessWidget {
  /// {@macro puzzle_logo}
  const PuzzleLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);

    // final artworkState =
    //     context.select((ArtworkBloc bloc) => bloc.state.status);
    // final collectionsState =
    //     context.select((CollectionsBloc bloc) => bloc.state.status);
    //
    // final isLoadedArtwork = artworkState == ArtworkStatus.success;
    // final isLoadedCollections = collectionsState == CollectionsStatus.success;
    // if (isLoadedArtwork == false || isLoadedCollections == false) {
    //   return const CircularProgressIndicator();
    // }

    return AppFlutterLogo(
      key: puzzleLogoKey,
    );
  }
}

/// {@template puzzle_sections}
/// Displays start and end sections of the puzzle.
/// {@endtemplate}
class PuzzleSections extends StatelessWidget {
  /// {@macro puzzle_sections}
  const PuzzleSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    // final artworkState =
    //     context.select((ArtworkBloc bloc) => bloc.state.status);
    // final collectionsState =
    //     context.select((CollectionsBloc bloc) => bloc.state.status);
    //
    // final isLoadedArtwork = artworkState == ArtworkStatus.success;
    // final isLoadedCollections = collectionsState == CollectionsStatus.success;
    // if (isLoadedArtwork == false || isLoadedCollections == false) {
    //   return const CircularProgressIndicator();
    // }

    return ResponsiveLayoutBuilder(
      small: (context, child) => Column(
        children: [
          theme.layoutDelegate.startSectionBuilder(state),
          const PuzzleMenu(),
          const PuzzleBoard(),
          theme.layoutDelegate.endSectionBuilder(state),
        ],
      ),
      medium: (context, child) => Column(
        children: [
          theme.layoutDelegate.startSectionBuilder(state),
          const PuzzleBoard(),
          theme.layoutDelegate.endSectionBuilder(state),
        ],
      ),
      large: (context, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: theme.layoutDelegate.startSectionBuilder(state),
          ),
          const PuzzleBoard(),
          Expanded(
            child: theme.layoutDelegate.endSectionBuilder(state),
          ),
        ],
      ),
    );
  }
}

/// {@template puzzle_board}
/// Displays the board of the puzzle.
/// {@endtemplate}
@visibleForTesting
class PuzzleBoard extends StatelessWidget {
  /// {@macro puzzle_board}
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);

    final size = puzzle.getDimension();
    if (size == 0) return const CircularProgressIndicator();

    // final artworkState =
    //     context.select((ArtworkBloc bloc) => bloc.state.status);
    // final collectionsState =
    //     context.select((CollectionsBloc bloc) => bloc.state.status);
    // final isLoadedArtwork = artworkState == ArtworkStatus.success;
    // final isLoadedCollections = collectionsState == CollectionsStatus.success;
    // if (isLoadedArtwork == false || isLoadedCollections == false) {
    //   return const CircularProgressIndicator();
    // }

    return PuzzleKeyboardHandler(
      child: BlocListener<PuzzleBloc, PuzzleState>(
        listener: (context, state) {
          if (theme.hasTimer && state.puzzleStatus == PuzzleStatus.complete) {
            context.read<TimerBloc>().add(const TimerStopped());
          }
        },
        child: theme.layoutDelegate.boardBuilder(
          size,
          puzzle.tiles
              .map(
                (tile) => _PuzzleTile(
                  key: Key('puzzle_tile_${tile.value.toString()}'),
                  tile: tile,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _PuzzleTile extends StatelessWidget {
  const _PuzzleTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    return tile.isWhitespace
        ? theme.layoutDelegate.whitespaceTileBuilder()
        : theme.layoutDelegate.tileBuilder(tile, state);
  }
}

/// {@template puzzle_menu}
/// Displays the menu of the puzzle.
/// {@endtemplate}
@visibleForTesting
class PuzzleMenu extends StatelessWidget {
  /// {@macro puzzle_menu}
  const PuzzleMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themes = context.select((ThemeBloc bloc) => bloc.state.themes);

    // final artworkState =
    //     context.select((ArtworkBloc bloc) => bloc.state.status);
    // final collectionsState =
    //     context.select((CollectionsBloc bloc) => bloc.state.status);
    //
    // final isLoadedArtwork = artworkState == ArtworkStatus.success;
    // final isLoadedCollections = collectionsState == CollectionsStatus.success;
    // if (isLoadedArtwork == false || isLoadedCollections == false) {
    //   return const CircularProgressIndicator();
    // }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
            onPressed: () async {
              debugPrint('CLICKME');
              await showAppDialog<void>(
                context: context,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<DashatarThemeBloc>(),
                    ),
                    BlocProvider.value(
                      value: context.read<ArtworkBloc>(),
                    ),
                    BlocProvider.value(
                      value: context.read<CollectionsBloc>(),
                    ),
                    BlocProvider.value(
                      value: context.read<PuzzleBloc>(),
                    ),
                    BlocProvider.value(
                      value: context.read<TimerBloc>(),
                    ),
                    BlocProvider.value(
                      value: context.read<AudioControlBloc>(),
                    ),
                  ],
                  child: const CollectionChooser(),
                ),
              );
            },
            icon: const Icon(Icons.icecream_outlined),
            label: const Text('Choose a Collection')),

        // ...List.generate(
        //   themes.length,
        //   (index) => PuzzleMenuItem(
        //     theme: themes[index],
        //     themeIndex: index,
        //   ),
        // ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const SizedBox(),
          medium: (_, child) => child!,
          large: (_, child) => child!,
          child: (currentSize) {
            return Row(
              children: [
                const Gap(44),
                AudioControl(
                  key: audioControlKey,
                )
              ],
            );
          },
        ),
      ],
    );
  }
}

/// {@template puzzle_menu_item}
/// Displays the menu item of the [PuzzleMenu].
/// {@endtemplate}
@visibleForTesting
class PuzzleMenuItem extends StatelessWidget {
  /// {@macro puzzle_menu_item}
  const PuzzleMenuItem({
    Key? key,
    required this.theme,
    required this.themeIndex,
  }) : super(key: key);

  /// The theme corresponding to this menu item.
  final PuzzleTheme theme;

  /// The index of [theme] in [ThemeState.themes].
  final int themeIndex;

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final isCurrentTheme = theme == currentTheme;

    return ResponsiveLayoutBuilder(
      small: (_, child) => Column(
        children: [
          Container(
            width: 100,
            height: 40,
            decoration: isCurrentTheme
                ? BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: currentTheme.menuUnderlineColor,
                      ),
                    ),
                  )
                : null,
            child: child,
          ),
        ],
      ),
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final leftPadding =
            themeIndex > 0 && currentSize != ResponsiveLayoutSize.small
                ? 40.0
                : 0.0;

        return Padding(
          padding: EdgeInsets.only(left: leftPadding),
          child: Tooltip(
            message:
                theme != currentTheme ? context.l10n.puzzleChangeTooltip : '',
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ).copyWith(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                // Ignore if this theme is already selected.
                if (theme == currentTheme) {
                  return;
                }

                // Update the currently selected theme.
                context
                    .read<ThemeBloc>()
                    .add(ThemeChanged(themeIndex: themeIndex));

                // Reset the timer of the currently running puzzle.
                context.read<TimerBloc>().add(const TimerReset());

                // Stop the Dashatar countdown if it has been started.
                context.read<DashatarPuzzleBloc>().add(
                      const DashatarCountdownStopped(),
                    );

                // Initialize the puzzle board for the newly selected theme.
                context.read<PuzzleBloc>().add(
                      const PuzzleInitialized(
                        shufflePuzzle: false,
                      ),
                    );
              },
              child: AnimatedDefaultTextStyle(
                duration: PuzzleThemeAnimationDuration.textStyle,
                style: PuzzleTextStyle.headline5.copyWith(
                  color: isCurrentTheme
                      ? currentTheme.menuActiveColor
                      : currentTheme.menuInactiveColor,
                ),
                child: Text(theme.name),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// The global key of [PuzzleLogo].
///
/// Used to animate the transition of [PuzzleLogo] when changing a theme.
final puzzleLogoKey = GlobalKey(debugLabel: 'puzzle_logo');

/// The global key of [PuzzleName].
///
/// Used to animate the transition of [PuzzleName] when changing a theme.
final puzzleNameKey = GlobalKey(debugLabel: 'puzzle_name');

/// The global key of [PuzzleTitle].
///
/// Used to animate the transition of [PuzzleTitle] when changing a theme.
final puzzleTitleKey = GlobalKey(debugLabel: 'puzzle_title');

/// The global key of [NumberOfMovesAndTilesLeft].
///
/// Used to animate the transition of [NumberOfMovesAndTilesLeft]
/// when changing a theme.
final numberOfMovesAndTilesLeftKey =
    GlobalKey(debugLabel: 'number_of_moves_and_tiles_left');

/// The global key of [AudioControl].
///
/// Used to animate the transition of [AudioControl]
/// when changing a theme.
final audioControlKey = GlobalKey(debugLabel: 'audio_control');
