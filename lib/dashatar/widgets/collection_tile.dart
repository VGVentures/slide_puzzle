import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return InkWell(
      onTap: () {
        // TODO: if not current collection, set current collection and close the modal
        debugPrint('ok');
      },
      child: Column(
        children: [
          Image.network(bannerImageUrl),
          Text(name),
          Text(description),
          Image.network(imageUrl),
        ],
      ),
    );
  }
}
