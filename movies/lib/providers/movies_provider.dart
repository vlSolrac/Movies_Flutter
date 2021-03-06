import 'package:flutter/material.dart';

import 'dart:async';
import 'package:movies/data/models/models.dart';
import 'package:movies/data/response/response.dart';
import 'package:movies/utils/debouncer.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  //-------------------------------------------------------------------------//
  // API VARIABLES

  final _apiKey       = "916ecdfa5c84489d85a058c66cb7302c";
  final _apiLanguage  = "es-ES";
  final _apiBaseUrl   = "api.themoviedb.org";
  final _apiNowPlayin = "3/movie/now_playing";
  final _apiPopular   = "3/movie/popular";
  final _apiUpcoming  = "3/movie/upcoming";
  final _apiTopRated  = "3/movie/top_rated";

  //-------------------------------------------------------------------------//
  // LIST'S OF MOVIES

  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies    = [];
  List<Movie> upcomingMovies   = [];
  List<Movie> topRatedMovies   = [];
  List<Movie> latestMovies     = [];

  //-------------------------------------------------------------------------//
  // MAP'S OF MOVIES AND CAST

  Map<String, List<Movie>> movieSeach = {};
  Map<int, List<Cast>>     movieCast  = {};

  //-------------------------------------------------------------------------//
  // PAGES

  int _pagesP        = 0;
  int _pagesPopular  = 1;
  int _pagesU        = 0;
  int _pagesUpcoming = 1;
  int _pagesR        = 0;
  int _pagesRated    = 1;


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
    getTopRatedMovies();
    getUpcomingMovies();

  }

  //-------------------------------------------------------------------------//
  // GET JSON DATA: FUNCTION TO GET INFO FROM SERVICE

  Future<dynamic> _getJsonData({ required String endpoint, int page = 1 }) async {
    final url = Uri.http( _apiBaseUrl, endpoint, {
      "api_key"  : _apiKey,
      "language" : _apiLanguage,
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
    _pagesP++;

    if (_pagesP <= _pagesPopular) {
      final response =
          await _getJsonData( endpoint: _apiPopular, page: _pagesP );

      final popularResponse = PopularResponse.fromJson( response );

      _pagesPopular = popularResponse.totalPages;

      popularMovies = [...popularMovies, ...popularResponse.results];

      notifyListeners();

      return popularMovies;

    } else {
      _pagesP--;
    }
  }

  //-------------------------------------------------------------------------//
  // GET UPCOMING MOVIES: FUNCTION TO GET INFO FROM SERVICE ABOUT UPCOMING MOVIES

  getUpcomingMovies() async {
    _pagesU ++;
    
    if ( _pagesU <= _pagesUpcoming ) {
      final response = await _getJsonData( endpoint: _apiUpcoming, page: _pagesU );

      final upcomingReponse = UpcomingResponse.fromJson( response );

      _pagesUpcoming = upcomingReponse.totalPages;

      upcomingMovies = [ ...upcomingMovies, ...upcomingReponse.results ];

      notifyListeners();

      return upcomingMovies;

    } else {
      _pagesU --;
    }
  }

  //-------------------------------------------------------------------------//
  // GET TOP RATED MOVIES: FUNCTION TO GET INFO FROM SERVICE ABOUT TOP RATED MOVIES

  getTopRatedMovies() async {
    _pagesR ++;
    
    if ( _pagesR <= _pagesRated ) {
      final response = await _getJsonData( endpoint: _apiTopRated, page: _pagesR );

      final topRatedReponse = TopRatedResponse.fromJson( response );

      _pagesRated = topRatedReponse.totalPages;

      topRatedMovies = [ ...topRatedMovies, ...topRatedReponse.results ];

      notifyListeners();

      return topRatedMovies;

    } else {
      _pagesR --;
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

  //-------------------------------------------------------------------------//
  //

}
