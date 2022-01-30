// ignore_for_file: public_member_api_docs

part of 'artwork_bloc.dart';

enum ArtworkStatus { initial, loading, success, failure }

class ArtworkState extends Equatable {
  const ArtworkState({
    this.status = ArtworkStatus.initial,
    this.artworks = const [],
    this.artwork = const MyCustomArtworkOne(),
  });

  final ArtworkStatus status;

  /// The list of all available [Artwork]s.
  final List<Artwork> artworks;

  /// Currently selected [Artwork].
  final Artwork artwork;

  @override
  List<Object> get props => [status, artworks, artwork];

  ArtworkState copyWith({
    ArtworkStatus Function()? status,
    List<Artwork> Function()? artworks,
    Artwork Function()? artwork,
  }) {
    return ArtworkState(
      status: status != null ? status() : this.status,
      artworks: artworks != null ? artworks() : this.artworks,
      artwork: artwork != null ? artwork() : this.artwork,
    );
  }
}
