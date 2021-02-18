import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviesapp/src/models/actors_models.dart';

import 'package:moviesapp/src/models/movie_model.dart';

class MoviesProvider {

String _apikey = 'f6109d608935f9aacd38e94f9aecc85c';
String _url = 'api.themoviedb.org';
String _language ='en-US';

int _popularsPage = 0;
bool _loading = false;

List<Movie> _populars = new List();

final _popularsStreamController = StreamController<List<Movie>>.broadcast();

Function(List<Movie>)get popularsSink => _popularsStreamController.sink.add;

Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

void disposeStreams(){
  _popularsStreamController?.close();
}

Future<List<Movie>> _processData (Uri url ) async {
final resp = await http.get( url);
final decodedData = json.decode(resp.body);

final movies = new Movies.fromJsonlist(decodedData['results']);

return movies.items;
}


Future<List<Movie>>getMoviesInCinema() async{

final url = Uri.https( _url,'3/movie/now_playing', {
  'api_key': _apikey,
  'language' : _language,
});
 
 return await _processData(url);

}

Future<List<Movie>>getPopulars() async {
  if (_loading) return []; 
  _loading = true;
  _popularsPage ++ ;

  final url = Uri.https( _url, '3/movie/popular',{
    'api_key': _apikey,
    'language' : _language,
    'page'     : _popularsPage.toString(),
  });

  final resp =  await _processData(url);

  _populars.addAll(resp);
  popularsSink( _populars );
  _loading = false;
  return resp;

}

Future<List<Actor>> getCast(String movieId) async  {

 final url = Uri.https( _url, '3/movie/$movieId/credits',{
  'api_key': _apikey,
  'language' : _language,
});
  final resp = await http.get(url);
  final decodedData = json.decode(resp.body);

  final cast = new Cast.fromJsonList(decodedData['cast']);

  return cast.actors;

}

Future<List<Movie>>searchMovie(String query) async{

final url = Uri.https( _url,'3/search/movie', {
  'api_key': _apikey,
  'language' : _language,
  'query' : query,
});
 
 return await _processData(url);

}

}