import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artwork.g.dart';

@JsonSerializable()
class Artwork extends Equatable {
  const Artwork({
    required this.id,
    required this.imageUrl,
    required this.permalink,
    required this.name,
    required this.description,
    required this.creator,
    required this.creatorProfileUrl,
    required this.creatorProfileImage,
  });

  factory Artwork.fromJson(Map<String, dynamic> json) => _$ArtworkFromJson(json);

  Map<String, dynamic> toJson() => _$ArtworkToJson(this);

  final int id;
  final String imageUrl;
  final String permalink;
  final String name;
  final String description;
  final String creator;
  final String creatorProfileUrl;
  final String creatorProfileImage;

  @override
  List<Object> get props => [
        id,
        imageUrl,
        permalink,
        name,
        description,
        creator,
        creatorProfileUrl,
        creatorProfileImage
      ];
}
