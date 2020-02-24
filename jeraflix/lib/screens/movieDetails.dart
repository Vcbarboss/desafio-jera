import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:catalogo/bloc/favoriteBloc.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieDetails extends StatelessWidget {

  Movie movie;

  final Map _movieData;



  var smallImage = "https://image.tmdb.org/t/p/w185/";
  var largeImage = "https://image.tmdb.org/t/p/w500/";

  MovieDetails(this._movieData);

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, Movie>>(
        stream: bloc.outFav,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return IconButton(
              icon: Icon(snapshot.data.containsKey(movie.id)
                  ? Icons.star
                  : Icons.star_border),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {

                bloc.toggleFavorite(movie);
              },
            );
          else
            return Text("Insira sua pesquisa!");
        },
      ),
    );
  }
}
