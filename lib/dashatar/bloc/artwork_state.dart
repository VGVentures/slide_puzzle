// ignore_for_file: public_member_api_docs

part of 'artwork_bloc.dart';

class ArtworkState extends Equatable {
  const ArtworkState({
    required this.artworks,
    this.artwork = const MyCustomArtworkOne(),
  });

  /// The list of all available [Artwork]s.
  final List<Artwork> artworks;

  /// Currently selected [Artwork].
  final Artwork artwork;

  @override
  List<Object> get props => [artworks, artwork];

  ArtworkState copyWith({
    List<Artwork>? artworks,
    Artwork? artwork,
  }) {
    return ArtworkState(
      artworks: artworks ?? this.artworks,
      artwork: artwork ?? this.artwork,
    );
  }
}
