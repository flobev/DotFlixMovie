import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:movie_flutter/models/movie.dart';
import 'package:movie_flutter/repositories/data_repository.dart';
// ignore: unused_import
import 'package:movie_flutter/services/api_service.dart';
import 'package:movie_flutter/ui/widgets/movie_card.dart';
import 'package:movie_flutter/ui/widgets/movie_category.dart';
import 'package:movie_flutter/utils/constant.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 500,
            child: MovieCard(movie: dataProvider.popularMovieList.first),
          ),
          MovieCategory(
            imageHeight: 160,
            imageWidth: 110,
            label: 'Tendances Actuelles',
            movieList: dataProvider.popularMovieList,
            callback: dataProvider.getPopularMovies,
          ),
          MovieCategory(
            imageHeight: 320,
            imageWidth: 220,
            label: 'Actuellement au cinéma',
            movieList: dataProvider.nowPlaying,
            callback: dataProvider.getNowPlaying,
          ),
          MovieCategory(
            imageHeight: 160,
            imageWidth: 110,
            label: 'Bientôt disponible',
            movieList: dataProvider.upcomingMovies,
            callback: dataProvider.getUpcomingMovies,
          ),
          MovieCategory(
            imageHeight: 320,
            imageWidth: 220,
            label: 'Animations',
            movieList: dataProvider.animationMovies,
            callback: dataProvider.getAnimationMovies,
          ),
          MovieCategory(
            imageHeight: 320,
            imageWidth: 220,
            label: 'Aventures',
            movieList: dataProvider.adventureMovies,
            callback: dataProvider.getAdventureMovies,
          ),
        ],
      ),
    );
  }
}
