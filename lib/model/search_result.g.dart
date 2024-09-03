// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      score: (json['score'] as num).toDouble(),
      show: Show.fromJson(json['show'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'score': instance.score,
      'show': instance.show,
    };

Show _$ShowFromJson(Map<String, dynamic> json) => Show(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      language: json['language'] as String?,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      image: json['image'] == null
          ? null
          : ShowImage.fromJson(json['image'] as Map<String, dynamic>),
      summary: json['summary'] as String?,
      runtime: (json['runtime'] as num?)?.toInt(),
      premiered: json['premiered'] as String?,
      rating: Rating.fromJson(json['rating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowToJson(Show instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'type': instance.type,
      'language': instance.language,
      'genres': instance.genres,
      'image': instance.image,
      'summary': instance.summary,
      'runtime': instance.runtime,
      'premiered': instance.premiered,
      'rating': instance.rating,
    };

ShowImage _$ShowImageFromJson(Map<String, dynamic> json) => ShowImage(
      medium: json['medium'] as String,
      original: json['original'] as String,
    );

Map<String, dynamic> _$ShowImageToJson(ShowImage instance) => <String, dynamic>{
      'medium': instance.medium,
      'original': instance.original,
    };

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      average: (json['average'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'average': instance.average,
    };
