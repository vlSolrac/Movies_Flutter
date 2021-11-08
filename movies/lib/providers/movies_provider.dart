import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/data/models/models.dart';
import 'package:movies/data/response/credist_response.dart';
import 'package:movies/data/response/response.dart';

import 'package:http/http.dart' as http;
import 'package:movies/utils/debouncer.dart';

class MoviesProvider extends ChangeNotifier {
  //-------------------------------------------------------------------------//
  // API VARIABLES

  final _apiKey       = "916ecdfa5c84489d85a058c66cb7302c";
  final _apiLanguage  = "es-ES";
  final _apiBaseUrl   = "api.themoviedb.org";
  final _apiNowPlayin = "3/movie/now_playing";
  final _apiPopular   = "3/movie/popular";
  final _apiSeacrh    = "3/search/movie";

  //-------------------------------------------------------------------------//
  // LIST'S OF MOVIES

  List<Movie> nowPlayingMovies = [];
  List<Movie> _popularMovies1  = [];
  List<Movie> popularMovies    = [];

  //-------------------------------------------------------------------------//
  // MAP'S OF MOVIES AND CAST

  Map<String, List<Movie>> movieSeach = {};
  Map<int, List<Cast>>     movieCast  = {};

  //-------------------------------------------------------------------------//
  // PAGES

  int _pages        = 0;
  int _pagesPopular = 1;

  //-------------------------------------------------------------------------//
  // DEBOUNCER

  final debouncer = Debouncer(
    duration: const Duration( milliseconds: 500 ),
  );

  final StreamController<List<Movie>> streamController =
      StreamController.broadcast();

  Stream<List<Movie>> get sugestionsStream => streamController.stream;

  //-------------------------------------------------------------------------//
  // CONSTUCTOR

  MoviesProvider() {
    getNowPlayingMovies();
    getPopularMovies();

  }

  //-------------------------------------------------------------------------//
  // GET JSON DATA: FUNCTION TO GET INFO FROM SERVICE

  Future<dynamic> _getJsonData({ required String endpoint, int page = 1 }) async {
    final url = Uri.http( _apiBaseUrl, endpoint, {
      "api_key"  : _apiKey,
      "languaje" : _apiLanguage,
      "page"     : "$page",
    });

    final response = await http.get(url);

    return response.body;
  }

  //-------------------------------------------------------------------------//
  // GET NOW PLAYING MOVIES: FUNCTION TO GET INFO FROM SERVICE ABOUT NOW PLAYIN MOVIES

  getNowPlayingMovies() async {
    final response = await _getJsonData( endpoint: _apiNowPlayin );

    final nowPlayingResponse = NowPlayingResponse.fromJson( response );

    nowPlayingMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  //-------------------------------------------------------------------------//
  // GET POPULAR MOVIES: FUNCTION TO GET INFO FROM SERVICE ABOUT POPULAR MOVIES

  getPopularMovies() async {
    _pages++;
    if ( _pages <= _pagesPopular ) {
      final response = await _getJsonData( endpoint: _apiPopular, page: _pages );

      final popularResponse = PopularResponse.fromJson( response );

      _pagesPopular = popularResponse.totalPages;

      _popularMovies1 = [..._popularMovies1, ...popularResponse.results];

      popularMovies = popularResponse.results;

      notifyListeners();

      return _popularMovies1;
    }
  }

  //-------------------------------------------------------------------------//
  // GET CAST MOVIE: FUNCTION TO GET INFO FROM SERVICE ABOUT CAST MOVIE

  Future<List<Cast>> getCastMovie ( int movieId ) async {
    if( movieCast.containsKey( movieId ) ) return movieCast[ movieId ]!;

    final response = await _getJsonData( endpoint: "3/movie/$movieId/credits" );

    final credistResponse = CreditsResponse.fromJson( response );

    movieCast[ movieId ]  = credistResponse.cast;

    return credistResponse.cast;

  }

  //-------------------------------------------------------------------------//
  // GET CAST MOVIE: FUNCTION TO GET INFO FROM SERVICE ABOUT CAST MOVIE

  Future<List<Movie>> searchMovie({ required String query }) async {
    if ( movieSeach.containsKey( query ) ) return movieSeach[ query ]!;
    final url = Uri.https( _apiBaseUrl, "3/search/movie", {
      "api_key"  : _apiKey,
      "language" : _apiLanguage,
      "query"    : query,
    });

    final response = await http.get( url );

    final searchResponse = SearchResponse.fromJson( response.body );

    movieSeach[ query ]  = searchResponse.results;

    return searchResponse.results;
  }

  void getSuggestionByQuery( String searchTerm ) {
    debouncer.value   = "";
    debouncer.onValue = ( value ) async {
      final resulst = await searchMovie( query: value );

      streamController.add( resulst );
    };

    final timer = Timer.periodic( const Duration( milliseconds: 300 ), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed( const Duration( milliseconds: 301 ) )
        .then( ( value ) => timer.cancel() );
  }

}
