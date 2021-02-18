import 'package:flutter/material.dart';
import 'package:moviesapp/src/models/movie_model.dart';
import 'package:moviesapp/src/providers/movies_providers.dart';
//This code allows to create a search menu. works on every code 
class DataSearch extends SearchDelegate{

  String selected = '';
  final moviesProvider = new MoviesProvider();

  final movies = [
    'Captain America'
    'Super man'
    'Batman'
    'Shazam'
    'Ironman'
    'Aquaman'

  ];

  final recentMovies = [
    'Spiderman',
    'Captain America'
  ];



  @override
  List<Widget> buildActions(BuildContext context) {
      
      return [
        IconButton(
          icon: Icon(Icons.clear) ,
          onPressed: (){
            query = '';
          },
          )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icon left appbar
      return IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation,
          ) ,
          onPressed: (){
            close(context, null);
          },
          );
      
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Create the results that will be showed 
     return Container(
       child: Container(
         height: 100.0,
         width: 100.0,
         color: Colors.blueGrey,
         child: Text(selected),
       ),
     );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Suggestions when a person types in the search bar 

    if (query.isEmpty) {
      return Container();

    }
    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final moviesy = snapshot.data;
          
          return ListView(
            children: moviesy.map( (movie){
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage( movie.getPosterImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                  ),
                  title: Text (movie.title),
                  onTap: (){
                    close(context,null);
                    movie.uniqueId = '';
                    Navigator.pushNamed(context, 'detail', arguments: movie);
                  },
              );
            }).toList()
          ); 
        } else {
          return Center(
            child: CircularProgressIndicator());
        }
      }, 
    );

  }


  //   @override
  //   Widget buildSuggestions(BuildContext context) {
  //   // Suggestions when a person types in the search bar 

  //  final suggestedList = ( query.isEmpty) 
  //                           ? recentMovies
  //                           : movies.where((p) => p.toLowerCase().startsWith(query.toLowerCase())
  //                           ).toList();



  //   return ListView.builder(
  //     itemCount: suggestedList.length,
  //     itemBuilder: (context, i){
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(suggestedList[i]),
  //         onTap: (){
  //           selected = suggestedList[i];
  //         },
  //       );
  //     },
  //     );

  // }

}