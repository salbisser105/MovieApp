import 'package:flutter/material.dart';
import 'package:moviesapp/src/providers/movies_providers.dart';
import 'package:moviesapp/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {


  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(
      centerTitle: false,
      title: Text('Cinema Movies'),
      backgroundColor: Colors.indigoAccent,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search), 
          onPressed: (){}
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
          height: 400.0,
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
      children: <Widget> [
        Text('Trending', style: Theme.of(context).textTheme.headline6),
        
        // FutureBuilder(
        //   future: Future,
        //   initialData: InitialData,
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     return ;
        //   },
        // ),

      ],
    ),
  );

}

}