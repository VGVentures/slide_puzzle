import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection extends Equatable {
  const Collection({
    required this.slug,
    required this.imageUrl,
    required this.bannerImageUrl,
    required this.name,
    required this.description,

  });

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  final String slug;
  final String imageUrl;
  final String bannerImageUrl;
  final String name;
  final String description;

  @override
  List<Object> get props => [
        slug,
        imageUrl,
        bannerImageUrl,
        name,
        description,
      ];
}
