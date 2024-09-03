import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'search_result.g.dart';

@JsonSerializable()
class SearchResult {
  final double score;
  final Show show;

  SearchResult({required this.score, required this.show});

  /// Connect the generated [_$SearchResultFromJson] function to the `fromJson` factory.
  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  /// Connect the generated [_$SearchResultToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}

@JsonSerializable()
class Show {
  final int id;
  final String url;
  final String name;
  final String type;
  final String? language;
  final List<String> genres;
  final ShowImage? image;
  final String? summary;
  final int? runtime;
  final String? premiered;
  final Rating rating;

  // final String updated;

  Show({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    this.language,
    required this.genres,
    this.image,
    this.summary,
    this.runtime,
    this.premiered,
    required this.rating,
    // required this.updated
  });

  /// Connect the generated [_$ShowFromJson] function to the `fromJson`
  /// factory.
  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);

  /// Connect the generated [_$ShowToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ShowToJson(this);
}

@JsonSerializable()
class ShowImage {
  final String medium;
  final String original;

  ShowImage({required this.medium, required this.original});

  /// Connect the generated [_$ShowImageFromJson] function to the `fromJson` factory.
  factory ShowImage.fromJson(Map<String, dynamic> json) =>
      _$ShowImageFromJson(json);

  /// Connect the generated [_$ShowImageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ShowImageToJson(this);
}

@JsonSerializable()
class Rating {
  final double? average;

  Rating({this.average});

  /// Connect the generated [_$RatingFromJson] function to the `fromJson` factory.
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  /// Connect the generated [_$ShowImageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

/*
class SearchResult {
  final double score;
  final Show show;

  SearchResult({required this.score, required this.show});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      score: json['score'],
      show: Show.fromJson(json['show']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'show': show,
    };
  }
}

class Show {
  final int id;
  final String url;
  final String name;
  final ShowImage? image;

  Show(
      {required this.id,
      required this.url,
      required this.name,
      required this.image});

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      image: json['image'] != null ? ShowImage.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'image': image?.toJson(),
    };
  }
}

class ShowImage {
  final String medium;
  final String original;

  ShowImage({required this.medium, required this.original});

  factory ShowImage.fromJson(Map<String, dynamic> json) {
    return ShowImage(
      medium: json['medium'],
      original: json['original'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medium': medium,
      'original': original,
    };
  }
}
*/
