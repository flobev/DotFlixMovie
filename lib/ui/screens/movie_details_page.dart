import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutter/models/movie.dart';
import 'package:movie_flutter/repositories/data_repository.dart';
import 'package:movie_flutter/ui/widgets/action_button.dart';
import 'package:movie_flutter/ui/widgets/movie_info.dart';
import 'package:movie_flutter/ui/widgets/my_video_player.dart';
import 'package:movie_flutter/utils/constant.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    Movie _movie = await dataProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      newMovie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
      ),
      body: newMovie == null
          ? Center(
              child: SpinKitFadingCircle(
              color: kPrimaryColor,
              size: 20,
            ))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: MyVideoPlayer(movieId: newMovie!.videos!.first),
                  ),
                  MovieInfo(movie: newMovie!),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    bgColor: Colors.white,
                    color: kBackgroundColor,
                    icon: Icons.play_arrow,
                    label: 'Lecture',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    bgColor: Colors.grey.withOpacity(0.3),
                    color: Colors.white,
                    icon: Icons.download,
                    label: 'Télécharger',
                  ),
                ],
              ),
            ),
    );
  }
}
