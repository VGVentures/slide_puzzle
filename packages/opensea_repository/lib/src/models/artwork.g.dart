// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artwork _$ArtworkFromJson(Map<String, dynamic> json) {
  return $checkedNew('Artwork', json, () {
    final val = Artwork(
      id: $checkedConvert(json, 'id', (v) => v as int),
      imageUrl: $checkedConvert(json, 'image_url', (v) => v as String),
      permalink: $checkedConvert(json, 'permalink', (v) => v as String),
      name: $checkedConvert(json, 'name', (v) => v as String),
      description: $checkedConvert(json, 'description', (v) => v as String),
      creator: $checkedConvert(json, 'creator', (v) => v as String),
      creatorProfileImage:
          $checkedConvert(json, 'creator_profile_image', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {
    'imageUrl': 'image_url',
    'creatorProfileImage': 'creator_profile_image'
  });
}

Map<String, dynamic> _$ArtworkToJson(Artwork instance) => <String, dynamic>{
      'id': instance.id,
      'image_url': instance.imageUrl,
      'permalink': instance.permalink,
      'name': instance.name,
      'description': instance.description,
      'creator': instance.creator,
      'creator_profile_image': instance.creatorProfileImage,
    };
