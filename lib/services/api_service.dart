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
}
