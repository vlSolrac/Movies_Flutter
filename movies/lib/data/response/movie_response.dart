import 'dart:convert';

import 'package:movies/data/models/movie.dart';

class LatesdResponse {
  LatesdResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory LatesdResponse.fromJson(String str) =>
      LatesdResponse.fromMap(json.decode(str));

  factory LatesdResponse.fromMap(Map<String, dynamic> json) => LatesdResponse(
        page: json["page"] ?? 0,
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
