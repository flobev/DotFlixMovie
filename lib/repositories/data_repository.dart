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

  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlaying => _nowPlaying;
  List<Movie> get upcomingMovies => _upcomingMovies;

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

  Future<void> initData() async {
    await getPopularMovies();
    await getNowPlaying();
    await getUpcomingMovies();
  }
}
