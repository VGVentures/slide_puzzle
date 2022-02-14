// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

class CollectionBanner extends StatelessWidget {
  /// individual collection item to show in the chooser listview
  const CollectionBanner({
    Key? key,
    required this.imageUrl,
    required this.bannerImageUrl,
  }) : super(key: key);

  final String imageUrl;
  final String bannerImageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.loose,
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      // overflow: Overflow.visible,
      children: [
        Container(
          // decoration:
          //     BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          // color: Colors.red,
          height: 158,
        ),
        Container(
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(bannerImageUrl),
            ),
          ),
          // clipBehavior: Clip.hardEdge,
          // child: Image.network(
          //   bannerImageUrl,
          //   // height: 120,
          //   fit: BoxFit.cover,
          //   // scale: 0.02,
          // ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imageUrl,
                ),
              ),
            ),
          ),
        ),
        // Text(name),
        // Text(description),
      ],
    );
  }
}
