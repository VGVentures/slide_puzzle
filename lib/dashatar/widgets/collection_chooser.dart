// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:nftpuzzlefun/colors/colors.dart';
import 'package:nftpuzzlefun/dashatar/widgets/collection_chooser_animated_builder.dart';
import 'package:nftpuzzlefun/dashatar/widgets/collection_tile.dart';
import 'package:nftpuzzlefun/layout/layout.dart';


class CollectionChooser extends StatefulWidget {
  const CollectionChooser({Key? key}) : super(key: key);

  @override
  State<CollectionChooser> createState() => _CollectionChooserState();
}

class _CollectionChooserState extends State<CollectionChooser>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    Future.delayed(
      const Duration(milliseconds: 140),
      _controller.forward,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(

      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final padding = currentSize == ResponsiveLayoutSize.large
            ? const EdgeInsets.fromLTRB(68, 82, 68, 73)
            : (currentSize == ResponsiveLayoutSize.medium
            ? const EdgeInsets.fromLTRB(48, 54, 48, 53)
            : const EdgeInsets.fromLTRB(20, 99, 20, 76));

        final closeIconOffset = currentSize == ResponsiveLayoutSize.large
            ? const Offset(44, 37)
            : (currentSize == ResponsiveLayoutSize.medium
            ? const Offset(25, 28)
            : const Offset(17, 63));

        final crossAxisAlignment = currentSize == ResponsiveLayoutSize.large
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center;

        return Stack(
          key: const Key('collection_chooser'),
          children: [
            SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    child: Padding(
                      padding: padding,
                      child: CollectionChooserAnimatedBuilder(
                        animation: _controller,
                        builder: (context, child, animation) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: crossAxisAlignment,
                            children: [
                              SlideTransition(
                                position: animation.scoreOffset,
                                child: Opacity(
                                  opacity: animation.scoreOpacity.value,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      CollectionTile(slug: 'one', name: 'one', description: 'Para Bellum  by Matty Mariansky - Art Blocks Curated', imageUrl: 'https://lh3.googleusercontent.com/1taWf5X3ymTt_QMBGLJ7nvfMVptJyxAxW2wplDIFWE0n_4BVxG9RYw6X6y4N991oP24_ERLt_sexJv1602DT_J6VeCcAyFIt6KG-', bannerImageUrl: 'https://lh3.googleusercontent.com/5-KeOMqOlfC7D6etYVEcrEiPcRy_QB-KPS3uOeGu7hMsPorzvPNtJOVrQRb1rxjHFcFsyXEQmTdj7bvqlbAQD5foHQxbTEgb5GPaMLg=s2500'),
                                      Container(
                                        height: 20,
                                      ),
                                      CollectionTile(slug: 'one', name: 'two', description: 'Para Bellum  by Matty Mariansky - Art Blocks Curated', imageUrl: 'https://lh3.googleusercontent.com/1taWf5X3ymTt_QMBGLJ7nvfMVptJyxAxW2wplDIFWE0n_4BVxG9RYw6X6y4N991oP24_ERLt_sexJv1602DT_J6VeCcAyFIt6KG-', bannerImageUrl: 'https://lh3.googleusercontent.com/5-KeOMqOlfC7D6etYVEcrEiPcRy_QB-KPS3uOeGu7hMsPorzvPNtJOVrQRb1rxjHFcFsyXEQmTdj7bvqlbAQD5foHQxbTEgb5GPaMLg=s2500'),
                                      Container(
                                        height: 20,
                                      ),
                                      CollectionTile(slug: 'one', name: 'three', description: 'Para Bellum  by Matty Mariansky - Art Blocks Curated', imageUrl: 'https://lh3.googleusercontent.com/1taWf5X3ymTt_QMBGLJ7nvfMVptJyxAxW2wplDIFWE0n_4BVxG9RYw6X6y4N991oP24_ERLt_sexJv1602DT_J6VeCcAyFIt6KG-', bannerImageUrl: 'https://lh3.googleusercontent.com/5-KeOMqOlfC7D6etYVEcrEiPcRy_QB-KPS3uOeGu7hMsPorzvPNtJOVrQRb1rxjHFcFsyXEQmTdj7bvqlbAQD5foHQxbTEgb5GPaMLg=s2500'),
                                    ],
                                  ),
                                ),
                              ),
                              const ResponsiveGap(
                                small: 40,
                                medium: 40,
                                large: 80,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              right: closeIconOffset.dx,
              top: closeIconOffset.dy,
              child: IconButton(
                key: const Key('dashatar_share_dialog_close_button'),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconSize: 18,
                icon: const Icon(
                  Icons.close,
                  color: PuzzleColors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },

    );
  }
}
