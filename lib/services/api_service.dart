import 'package:dio/dio.dart';
import 'package:movie_flutter/models/movie.dart';
import 'package:movie_flutter/services/api.dart';

class ApiService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    // en construit l'url
    String _url = api.baseUrl + path;

    // On construit les paramètres de la requête
    Map<String, dynamic> query = {
      'api_key': api.apiMoviekey,
      'language': 'fr-FR'
    };

    // Si params n'est pas null, on ajoute son contenu à query
    if (params != null) {
      query.addAll(params);
    }

    // Appel de l'api movie
    final response = await dio.get(_url, queryParameters: query);

    // On vérifie si la requête s'est bien déroulée
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response = await getData('/movie/popular', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response = await getData('/movie/now_playing', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpcomingMovies({required int pageNumber}) async {
    Response response = await getData('/movie/upcoming', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAnimationMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie', params: {
      'page': pageNumber,
      'with_genres': '16',
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAdventureMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie', params: {
      'page': pageNumber,
      'with_genres': '12',
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}');

    if (response.statusCode == 200) {
      Map<String, dynamic> _data = response.data;
      var genres = _data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      Movie newMovie = movie.copyWith(
        genres: genreList,
        releaseDate: _data['release_date'],
        vote: _data['vote_average'],
      );
      return newMovie;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieVideos({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/videos');
    if (response.statusCode == 200) {
      Map<String, dynamic> _data = response.data;

      List<String> videoKeys = _data['results'].map((dynamic videoJson) {
        return videoJson['key'] as String;
      }).toList();

      return movie.copyWith(videos: videoKeys);
    } else {
      throw response;
    }
  }
}
