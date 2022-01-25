import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:opensea_repository/opensea_repository.dart' hide Artwork;
import 'package:opensea_repository/opensea_repository.dart'
as opensea_repository;

part 'artwork.g.dart';

@JsonSerializable()
/// Artwork is a single asset from OpenSea
class Artwork extends Equatable {
  /// Artwork is a single asset from OpenSea
  const Artwork({
    required this.id,
    required this.imageUrl,
    required this.permalink,
    required this.name,
    required this.description,
    required this.creator,
    required this.creatorProfileImage,
  });

  /// Artwork is a single asset from OpenSea
  factory Artwork.fromJson(Map<String, dynamic> json) =>
      _$ArtworkFromJson(json);

  /// Artwork is a single asset from OpenSea
  factory Artwork.fromRepository(opensea_repository.Artwork artwork) {
    return Artwork(
      id: artwork.id,
      imageUrl: artwork.imageUrl,
      permalink: artwork.permalink,
      name: artwork.name,
      description: artwork.description,
      creator: artwork.creator,
      creatorProfileImage: artwork.creatorProfileImage,
    );
  }

  /// Artwork is a single asset from OpenSea
  static const empty = Artwork(
    id: 1,
    imageUrl: 'a',
    permalink: 'a',
    name: 'a',
    description: 'a',
    creator: 'a',
    creatorProfileImage: 'a',
  );

  /// Artwork is a single asset from OpenSea
  final int id;
  /// Artwork is a single asset from OpenSea
  final String imageUrl;
  /// Artwork is a single asset from OpenSea
  final String permalink;
  /// Artwork is a single asset from OpenSea
  final String name;
  /// Artwork is a single asset from OpenSea
  final String description;
  /// Artwork is a single asset from OpenSea
  final String creator;
  /// Artwork is a single asset from OpenSea
  final String creatorProfileImage;

  @override
  List<Object> get props => [
    id,
    imageUrl,
    permalink,
    name,
    description,
    creator,
    creatorProfileImage
  ];

  /// Artwork is a single asset from OpenSea
  Map<String, dynamic> toJson() => _$ArtworkToJson(this);

  /// Artwork is a single asset from OpenSea
  Artwork copyWith({
    int? id,
    String? imageUrl,
    String? permalink,
    String? name,
    String? description,
    String? creator,
    String? creatorProfileImage,
  }) {
    return Artwork(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      permalink: permalink ?? this.permalink,
      name: name ?? this.name,
      description: description ?? this.description,
      creator: creator ?? this.creator,
      creatorProfileImage: creatorProfileImage ?? this.creatorProfileImage,
    );
  }
}
