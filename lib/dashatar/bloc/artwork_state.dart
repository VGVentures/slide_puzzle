// ignore_for_file: public_member_api_docs

part of 'artwork_bloc.dart';

enum ArtworkStatus { initial, loading, success, failure }

class ArtworkState extends Equatable {
  const ArtworkState({
    this.status = ArtworkStatus.initial,
    this.artworks = const [],
    this.artworkSplitImages = const [],
    this.artwork = 0,
  });

  final ArtworkStatus status;

  /// The list of all available [Artwork]s.
  final List<Artwork> artworks;
  final List<List<Image>> artworkSplitImages;

  /// Currently selected [Artwork].
  final int artwork;

  @override
  List<Object> get props => [status, artworks, artworkSplitImages, artwork];

  ArtworkState copyWith({
    ArtworkStatus Function()? status,
    List<Artwork> Function()? artworks,
    List<List<Image>> Function()? artworkSplitImages,
    int Function()? artwork,
  }) {
    return ArtworkState(
      status: status != null ? status() : this.status,
      artworks: artworks != null ? artworks() : this.artworks,
      artworkSplitImages: artworkSplitImages != null ? artworkSplitImages() : this.artworkSplitImages,
      artwork: artwork != null ? artwork() : this.artwork,
    );
  }
}
