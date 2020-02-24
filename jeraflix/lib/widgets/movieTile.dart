import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:catalogo/bloc/favoriteBloc.dart';
import 'package:catalogo/models/movie.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {

  final Movie movie;
  var smallImage = "https://image.tmdb.org/t/p/w185/";
  var largeImage = "https://image.tmdb.org/t/p/w500/";


  MovieTile(this.movie);

  //

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(aspectRatio: 16.9/9.0,
          child: Image.network(largeImage + movie.posterPath, fit: BoxFit.cover,),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        movie.title,
                        style: TextStyle(
                            color: Color.fromARGB(255, 13, 181, 81),
                            fontSize: 16
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<Map<String, Movie>>(
                stream: bloc.outFav,
                initialData: {},
                builder: (context, snapshot){
                  if(snapshot.hasData)
                    return IconButton(
                      icon: Icon(snapshot.data.containsKey(movie.id) ?
                      Icons.star : Icons.star_border),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: (){
                        bloc.toggleFavorite(movie);
                      },
                    );
                  else
                    return CircularProgressIndicator();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
