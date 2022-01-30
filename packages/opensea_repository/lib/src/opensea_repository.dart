import 'dart:async';

// import 'package:opensea_api/opensea_api.dart';
// import 'package:opensea_dart/enums/enums.dart';
import 'package:opensea_dart/opensea_dart.dart';
import 'package:opensea_dart/pojo/assets_object.dart';
import 'package:opensea_repository/opensea_repository.dart';
import 'api_key.dart';

class ArtworkFailure implements Exception {}

class ArtworkRepository {
  ArtworkRepository({OpenSea? artworkApiClient})
      : _artworkApiClient = artworkApiClient ?? OpenSea(apiKey);

  final OpenSea _artworkApiClient;

  Future<List<Artwork>> getArtworksByCollection(String collection) async {
    ///getAssets
    // orderBy: OrderBy.saleDate, orderDirection: OrderDirection.asc (optional)
    final myArtworks = await _artworkApiClient
        .getAssets(limit: '3', offset: '0', collection: collection)
        .then(myArtworkConverter);
    print('GETMY ASSETS');

    return myArtworks;
  }

  List<Artwork> myArtworkConverter(AssetsObject value) {
    final artworksList = <Artwork>[];
    value.assets?.forEach((element) {
      print('NEXT');
      print(element);
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
