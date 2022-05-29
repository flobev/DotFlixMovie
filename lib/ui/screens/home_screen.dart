import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutter/models/movie.dart';
import 'package:movie_flutter/repositories/data_repository.dart';
import 'package:movie_flutter/services/api_service.dart';
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
          Container(
            height: 500,
            color: const Color.fromARGB(255, 59, 2, 151),
            child: dataProvider.popularMovieList.isEmpty
                ? const Center()
                : Image.network(dataProvider.popularMovieList[0].posterUrl(),
                    fit: BoxFit.cover),
          ),
          const SizedBox(height: 15),
          Text(
            'Tendances actuelles',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 100,
                    color: lstPurpleColor,
                    child: dataProvider.popularMovieList.isEmpty
                        ? Center(child: Text(index.toString()))
                        : Image.network(
                            dataProvider.popularMovieList[index].posterUrl(),
                            fit: BoxFit.cover));
              },
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Actuellement au cinéma',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 220,
                  color: lstYellowOrangeColor,
                  child: Center(child: Text(index.toString())),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Bientôt disponible',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 110,
                  color: lstBlueColor,
                  child: Center(child: Text(index.toString())),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
