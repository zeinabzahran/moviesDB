import 'package:flutter/material.dart';
import 'package:movies/moviesModel.dart';
import 'package:movies/services.dart';
import 'moviesList.dart';

Future<void> main() async {
  MoviesModel movies=await getMovies();
  runApp(MyApp(movies:movies));
}

class MyApp extends StatelessWidget {
  final MoviesModel movies;
  MyApp({Key key, this.movies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies DB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Movies(movies: movies,),
      debugShowCheckedModeBanner: false,

    );
  }
}