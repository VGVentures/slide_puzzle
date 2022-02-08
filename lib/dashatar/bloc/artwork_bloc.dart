// import 'dart:ui';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:nftpuzzlefun/dashatar/artworks/my_custom_artwork_one.dart';
import 'package:nftpuzzlefun/helpers/squaresplitter.dart';
import 'package:opensea_repository/opensea_repository.dart';

part 'artwork_event.dart';
part 'artwork_state.dart';

/// doc
class ArtworkBloc extends Bloc<ArtworkEvent, ArtworkState> {
  /// doc
  ArtworkBloc({
    required ArtworkRepository artworkRepository,
  })  : _artworkRepository = artworkRepository,
        super(const ArtworkState()) {
    on<ArtworkSubscriptionRequested>(_onSubscriptionRequested);

    // on<ArtworkEvent>(_onArtworkChanged);
    on<ArtworkChanged>(_onArtworkChanged);
  }

  final ArtworkRepository _artworkRepository;

  Future<void> _onSubscriptionRequested(
    ArtworkSubscriptionRequested event,
    Emitter<ArtworkState> emit,
  ) async {
    debugPrint('SUBSCRIPTION REQUESTED');
    emit(state.copyWith(status: () => ArtworkStatus.loading));

    // a few to try: doodles-official, dartart, themushroompeople,
    // copypasteearth, para-bellum-by-matty-mariansky
    const collection = 'doodles-official';

    try {
      final artworks =
          await _artworkRepository.getArtworksByCollection(collection);
      debugPrint('COLLECTION RECEIVED');
      
      /// Process images
      final artworkSplitImages = List<List<Image>>.empty(growable: true);

      for (final artwork in artworks) {
        // artworkSplitImages[aIndex]
        final mySplitImages = await splitImage(
            inputImage: artwork.imageUrl,
            horizontalPieceCount: 4,
            verticalPieceCount: 4,
        );
        artworkSplitImages.add(mySplitImages);
        debugPrint(artwork.imageUrl);
      }

      emit(
        state.copyWith(
          status: () => ArtworkStatus.success,
          artworks: () => artworks,
          artworkSplitImages: () => artworkSplitImages,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: () => ArtworkStatus.failure));
    }
  }

  // var artworks = await
  //     _artworkRepository.getArtworksByCollection(collection);
  // await emit.forEach<List<Artwork>>(
  //   _artworkRepository.getArtworksByCollection(collection),
  //   onData: (artworks) => state.copyWith(
  //     status: () => ArtworkStatus.success,
  //     artworks: () => artworks,
  //   ),
  //   onError: (_, __) => state.copyWith(
  //     status: () => ArtworkStatus.failure,
  //   ),
  // );
  // }

  void _onArtworkChanged(
    ArtworkChanged event,
    Emitter<ArtworkState> emit,
  ) {
    emit(state.copyWith(artwork: () => event.artworkIndex));
  }

  // Future<void> fetchArtworksByCollection(String? collection) async {
  //   if (collection == null || collection.isEmpty) return;
  //
  //   // emit(state.copyWith(status: ArtworkStatus.loading));
  //
  //   try {
  //     final artworks = Artwork.fromRepository(
  //       await _weatherRepository.getWeather(collection),
  //     );
  //     final units = state.temperatureUnits;
  //     final value = units.isFahrenheit
  //         ? weather.temperature.value.toFahrenheit()
  //         : weather.temperature.value;
  //
  //     // emit(
  //     //   state.copyWith(
  //     //     status: WeatherStatus.success,
  //     //     temperatureUnits: units,
  //     //     weather: weather.copyWith(temperature: Temperature(value: value)),
  //     //   ),
  //     // );
  //   } on Exception {
  //     emit(state.copyWith(status: WeatherStatus.failure));
  //   }
  // }

  // Future<void> refreshWeather() async {
  //   if (!state.status.isSuccess) return;
  //   if (state.weather == Weather.empty) return;
  //   try {
  //     final weather = Weather.fromRepository(
  //       await _weatherRepository.getWeather(state.weather.collection),
  //     );
  //     final units = state.temperatureUnits;
  //     final value = units.isFahrenheit
  //         ? weather.temperature.value.toFahrenheit()
  //         : weather.temperature.value;
  //
  //     emit(
  //       state.copyWith(
  //         status: WeatherStatus.success,
  //         temperatureUnits: units,
  //         weather: weather.copyWith(temperature: Temperature(value: value)),
  //       ),
  //     );
  //   } on Exception {
  //     emit(state);
  //   }
  // }
}
