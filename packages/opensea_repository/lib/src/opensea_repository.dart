import 'dart:async';

// import 'package:opensea_api/opensea_api.dart';
// import 'package:opensea_dart/enums/enums.dart';
import 'package:opensea_dart/opensea_dart.dart';
import 'package:opensea_dart/pojo/assets_object.dart' as assetsapi;
import 'package:opensea_dart/pojo/collection_object.dart' as collectionapi;
import 'package:opensea_repository/opensea_repository.dart';
import 'api_key.dart';

class ArtworkFailure implements Exception {}

class ArtworkRepository {
  ArtworkRepository({OpenSea? artworkApiClient})
      : _artworkApiClient = artworkApiClient ?? OpenSea(apiKey);

  final OpenSea _artworkApiClient;

  Future<List<Artwork>> getArtworksByCollection(String collection) async {
    /// getAssets
    // orderBy: OrderBy.saleDate, orderDirection: OrderDirection.asc (optional)
    final myArtworks = await _artworkApiClient
        .getAssets(limit: '3', offset: '0', collection: collection)
        .then(myArtworkConverter);
    print('GET MY ASSETS');

    return myArtworks;
  }

  Future<List<Collection>> getCollectionsByCollectionList(
      List<String> collections) async {
    /// getCollection
    final collectionsList = <Collection>[];

    for (final collectionSlug in collections) {
      final myCollection = await _artworkApiClient.getCollection(collectionSlug)
      .then(myCollectionConverter);
      print('GET MY COLLECTION');
      collectionsList.add(myCollection);
    }
    return collectionsList;
  }

  Collection myCollectionConverter(collectionapi.CollectionObject value) {
    // final collectionsList = <Collection>[];
    // value.collection?.forEach((element) {
      // print('NEXT');
      // print(element);
      final singleCollection = Collection(
        slug: value.collection!.slug.toString(),
        name: value.collection!.name.toString(),
        description: value.collection!.description.toString(),
        imageUrl: value.collection!.imageUrl.toString(),
        bannerImageUrl: value.collection!.bannerImageUrl.toString(),
      );

      // collectionsList.add(singleCollection);
    // }
    // );

    // print(value);
    return singleCollection;
  }

  List<Artwork> myArtworkConverter(assetsapi.AssetsObject value) {
    // TODO: move squaresplitter stuff here  rather then in the bloc? Might make it easier to cache the cut images either locally or in firebase
    final artworksList = <Artwork>[];
    value.assets?.forEach((element) {
      // print('NEXT');
      // print(element);
      final singleArtwork = Artwork(
        creator: element.creator?.user.toString() as String,
        name: element.name.toString(),
        description: element.description.toString(),
        id: int.parse(element.id.toString()),
        creatorProfileImage:
            element.creator?.profileImgUrl.toString() as String,
        imageUrl: element.imageUrl.toString(),
        permalink: element.permalink.toString(),
      );

      artworksList.add(singleArtwork);
    });

    // print(value);
    return artworksList;
  }
}

// extension on WeatherState {
//   WeatherCondition get toCondition {
//     switch (this) {
//       case WeatherState.clear:
//         return WeatherCondition.clear;
//       case WeatherState.snow:
//       case WeatherState.sleet:
//       case WeatherState.hail:
//         return WeatherCondition.snowy;
//       case WeatherState.thunderstorm:
//       case WeatherState.heavyRain:
//       case WeatherState.lightRain:
//       case WeatherState.showers:
//         return WeatherCondition.rainy;
//       case WeatherState.heavyCloud:
//       case WeatherState.lightCloud:
//         return WeatherCondition.cloudy;
//       default:
//         return WeatherCondition.unknown;
//     }
//   }
// }
