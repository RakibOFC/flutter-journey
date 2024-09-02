import 'dart:convert';

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

  Show({required this.id, required this.url, required this.name});

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      url: json['url'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
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
