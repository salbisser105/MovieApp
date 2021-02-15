import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:moviesapp/src/models/movie_model.dart';

class MoviesProvider {

String _apikey = 'f6109d608935f9aacd38e94f9aecc85c';
String _url = 'https://api.themoviedb.org';
String _language ='en-US';


Future<List<Movie>>getMoviesInCinema() async{

final url = Uri.https(_url,'3/movie/now_playing', {
  'api_key': _apikey,
  'language' : _language,
});

final resp = await http.get( url);
final decodedData = json.decode(resp.body);

final movies = new Movies.fromJsonlist(decodedData['results']);

return movies.items;

}




}