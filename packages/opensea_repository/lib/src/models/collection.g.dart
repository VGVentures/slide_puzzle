// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return $checkedNew('Collection', json, () {
    final val = Collection(
      slug: $checkedConvert(json, 'slug', (v) => v as String),
      imageUrl: $checkedConvert(json, 'image_url', (v) => v as String),
      bannerImageUrl:
          $checkedConvert(json, 'banner_image_url', (v) => v as String),
      name: $checkedConvert(json, 'name', (v) => v as String),
      description: $checkedConvert(json, 'description', (v) => v as String),
    );
    return val;
  }, fieldKeyMap: const {
    'imageUrl': 'image_url',
    'bannerImageUrl': 'banner_image_url'
  });
}

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'image_url': instance.imageUrl,
      'banner_image_url': instance.bannerImageUrl,
      'name': instance.name,
      'description': instance.description,
    };
