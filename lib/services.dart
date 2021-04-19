import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movies/moviesModel.dart';

Future <MoviesModel> getMovies() async
{
  http.Response response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=053c138c6acf9c8ca9cd453d5179b632'),headers : {
    'Content-Type': 'application/json',
  });

  if (response.statusCode == 200) {
    MoviesModel moviesModel = MoviesModelFromJson(response.body.toString());
    return moviesModel;
  }
  else {
    print(response.reasonPhrase);
    return null;
  }
}