import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/search_result.dart';

class ApiService {
  static const String baseUrl = 'https://api.tvmaze.com/';

  Future<List<SearchResult>> fetchShows(String query) async {
    final response =
        await http.get(Uri.parse('${baseUrl}search/shows?q=$query'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((show) => SearchResult.fromJson(show)).toList();
    } else {
      throw Exception('Failed to load shows');
    }
  }
}
