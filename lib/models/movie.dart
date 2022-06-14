// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_flutter/services/api.dart';

class Movie {
  final int id;
  final String name;
  final String description;
  final String? posterPath;
  final List<String>? genres;
  final String? releaseDate;
  final double? vote;
  final List<String>? videos;

  Movie({
    required this.id,
    required this.name,
    required this.description,
    this.posterPath,
    this.genres,
    this.releaseDate,
    this.vote,
    this.videos,
  });

  Movie copyWith({
    int? id,
    String? name,
    String? description,
    String? posterPath,
    List<String>? genres,
    String? releaseDate,
    double? vote,
    List<String>? videos,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      posterPath: posterPath ?? this.posterPath,
      genres: genres ?? this.genres,
      releaseDate: releaseDate ?? this.releaseDate,
      vote: vote ?? this.vote,
      videos: videos ?? this.videos,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      name: map['title'],
      description: map['overview'],
      posterPath: map['poster_path'],
    );
  }

  String posterUrl() {
    API api = API();
    return api.baseImageURl + posterPath!;
  }

  String reformatGenres() {
    String categories = '';
    for (var i = 0; i < genres!.length; i++) {
      if (i == genres!.length - 1) {
        categories = categories + genres![i];
      } else {
        categories = categories + '${genres![i]}, ';
      }
    }
    return categories;
  }
}
