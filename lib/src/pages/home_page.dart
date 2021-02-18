import 'package:flutter/material.dart';
import 'package:moviesapp/src/providers/movies_providers.dart';
import 'package:moviesapp/src/search/search_delegate.dart';
import 'package:moviesapp/src/widgets/card_swiper_widget.dart';
import 'package:moviesapp/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {


  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

  moviesProvider.getPopulars();

    return Scaffold(
    appBar: AppBar(
      centerTitle: false,
      title: Text('Cinema Movies'),
      backgroundColor: Colors.indigoAccent,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search), 
          onPressed: (){
            showSearch(
            context:context ,
            delegate: DataSearch(),
            //query: 
            );
          }
          )
      ],
    ),
    body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _cardSwiper(),
          _footer(context),
        ],
      ),
    ),
    );
  }

  Widget _cardSwiper() {

    return FutureBuilder(
      future: moviesProvider.getMoviesInCinema(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        
      if (snapshot.hasData){
        return CardSwiper(
        movies: snapshot.data,
      );
      }else {
        return Container(
          height: 300.0,
          child: Center(
            child:CircularProgressIndicator()
            ),
        );
      }
      },
    ); 
}

Widget _footer(BuildContext context){

  return Container(
    width: double.infinity,
    
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Container(
          padding: EdgeInsets.only(left:20.0),
        child:Text('Trending', style: Theme.of(context).textTheme.headline6)
        ),
        SizedBox(height: 5.0),   
        StreamBuilder(
          stream: moviesProvider.popularsStream,        
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            
            if(snapshot.hasData){
              return MovieHorizontal(
                movies: snapshot.data,
                nextPage: moviesProvider.getPopulars,
                
                );
            }else {
              return Center(child: CircularProgressIndicator());
            }
            
          },
          
        ),
        
      ],
    ),
  );

}

}