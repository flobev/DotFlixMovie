import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_flutter/models/movie.dart';
import 'package:movie_flutter/services/api_service.dart';

class DataRepository with ChangeNotifier {
  final ApiService apiService = ApiService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;
  final List<Movie> _nowPlaying = [];
  int _nowPlayingPageIndex = 1;
  final List<Movie> _upcomingMovies = [];
  int _upcomingMoviesPageIndex = 1;
  final List<Movie> _animationMovies = [];
  int _animationMoviesPageIndex = 1;
  final List<Movie> _adventureMovies = [];
  int _adventureMoviesPageIndex = 1;

  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlaying => _nowPlaying;
  List<Movie> get upcomingMovies => _upcomingMovies;
  List<Movie> get animationMovies => _animationMovies;
  List<Movie> get adventureMovies => _adventureMovies;

  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies =
          await apiService.getPopularMovies(pageNumber: _popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      // ignore: avoid_print
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getNowPlaying() async {
    try {
      List<Movie> movies =
          await apiService.getNowPlaying(pageNumber: _nowPlayingPageIndex);
      _nowPlaying.addAll(movies);
      _nowPlayingPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      // ignore: avoid_print
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getUpcomingMovies() async {
    try {
      List<Movie> movies = await apiService.getUpcomingMovies(
          pageNumber: _upcomingMoviesPageIndex);
      _upcomingMovies.addAll(movies);
      _upcomingMoviesPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      // ignore: avoid_print
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getAnimationMovies() async {
    try {
      List<Movie> movies = await apiService.getAnimationMovies(
          pageNumber: _animationMoviesPageIndex);
      _animationMovies.addAll(movies);
      _animationMoviesPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      // ignore: avoid_print
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getAdventureMovies() async {
    try {
      List<Movie> movies = await apiService.getAdventureMovies(
          pageNumber: _adventureMoviesPageIndex);
      _adventureMovies.addAll(movies);
      _adventureMoviesPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      // ignore: avoid_print
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    try {
      Movie newMovie = await apiService.getMovieDetails(movie: movie);
      newMovie = await apiService.getMovieVideos(movie: newMovie);
      return newMovie;
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> initData() async {
    await Future.wait([
      getPopularMovies(),
      getNowPlaying(),
      getUpcomingMovies(),
      getAnimationMovies(),
      getAdventureMovies(),
    ]);
  }
}
