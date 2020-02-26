import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:catalogo/bloc/favoriteBloc.dart';
import 'package:catalogo/models/movie.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var largeImage = "https://image.tmdb.org/t/p/w500/";

    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Assistir Mais Tarde"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Movie>>(
          stream: bloc.outFav,
          initialData: {},
          builder: (context, snapshot){
            return ListView(
              children: snapshot.data.values.map((v){
                return InkWell(
                  onLongPress: (){
                    bloc.toggleFavorite(v);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 50,
                        child: Image.network(largeImage + v.backdropPath),
                      ),
                      Expanded(
                        child: Text(
                          v.title, style: TextStyle(color: Colors.white70),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          }
      ),
    );
  }
}
