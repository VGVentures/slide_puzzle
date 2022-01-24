/// API returns: id, image_url, token_id, permalink, background_color, name
/// These need to get changed to lowerCamelCase in Dart

import 'package:json_annotation/json_annotation.dart';

part 'asset.g.dart';

@JsonSerializable()
class Asset {
  const Asset({
    required this.id,
    required this.imageUrl,
    required this.tokenId,
    required this.permalink,
    required this.backgroundColor,
    required this.name,
    required this.numSales,
    required this.imagePreviewUrl,
    // required this.creator,
  });

  factory Asset.fromJson(Map<String, dynamic> json) =>
      _$AssetFromJson(json);

  final int id;
  // @JsonKey(name: 'image_url')
  final String imageUrl;
  final String tokenId;
  final String permalink;
  final String backgroundColor;
  final String name;
  final int numSales;
  // @JsonKey(name: 'image_preview_url')
  final String imagePreviewUrl;
  // @CreatorConverter()
  // final String creator;
}

// class CreatorConverter implements JsonConverter<String, String> {
//   const
// }