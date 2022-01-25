// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artwork _$ArtworkFromJson(Map<String, dynamic> json) {
  return Artwork(
    id: json['id'] as int,
    imageUrl: json['imageUrl'] as String,
    permalink: json['permalink'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    creator: json['creator'] as String,
    creatorProfileImage: json['creatorProfileImage'] as String,
  );
}

Map<String, dynamic> _$ArtworkToJson(Artwork instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'permalink': instance.permalink,
      'name': instance.name,
      'description': instance.description,
      'creator': instance.creator,
      'creatorProfileImage': instance.creatorProfileImage,
    };
