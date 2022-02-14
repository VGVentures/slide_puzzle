// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

import 'package:nftpuzzlefun/dashatar/widgets/collection_banner.dart';

/// individual collection item to show in the chooser listview
class CollectionTile extends StatelessWidget {
  /// individual collection item to show in the chooser listview
  const CollectionTile({
    Key? key,
    required this.slug,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.bannerImageUrl,
  }) : super(key: key);

  final String slug;
  final String name;
  final String description;
  final String imageUrl;
  final String bannerImageUrl;

  @override
  Widget build(BuildContext context) {
    // TODO: make collection item look nice in list format
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          // TODO: if not current collection, set current collection and close the modal
          debugPrint('ok' + slug);
        },
        child: Column(
          children: [
            CollectionBanner(
              bannerImageUrl: bannerImageUrl,
              imageUrl: imageUrl,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
