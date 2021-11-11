import 'dart:convert';

import 'package:movies/data/models/movie.dart';

class LatestResponse {
  LatestResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory LatestResponse.fromJson(String str) =>
      LatestResponse.fromMap(json.decode(str));

  factory LatestResponse.fromMap(Map<String, dynamic> json) => LatestResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
