// ignore_for_file: public_member_api_docs

// import 'my_custom_artwork.dart';

// import 'my_custom_artwork.dart';

import 'package:nftpuzzlefun/dashatar/artworks/my_custom_artwork.dart';

class MyCustomArtworkOne extends MyCustomArtwork {
  const MyCustomArtworkOne() : super();

  @override
  String get imageUrl => 'assets/images/dashatar/gallery/green.png';

  @override
  int get id => 1234;

  @override
  String get description => 'description';

  @override
  String get name => 'title of artwork';
}
