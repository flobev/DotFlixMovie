import 'package:flutter/material.dart';
import 'package:movie_flutter/repositories/data_repository.dart';
// ignore: unused_import
import 'package:movie_flutter/ui/screens/home_screen.dart';
import 'package:movie_flutter/ui/screens/loading_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => DataRepository(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingScreen(),
    );
  }
}
