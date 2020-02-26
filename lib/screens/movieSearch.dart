import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:catalogo/bloc/moviesBloc.dart';
import 'package:catalogo/delegates/data_search.dart';
import 'package:catalogo/models/movie.dart';
import 'package:catalogo/screens/favorites.dart';
import 'package:catalogo/widgets/movieTile.dart';
import 'package:flutter/material.dart';

import '../bloc/favoriteBloc.dart';


class MovieSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<MoviesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Filmes",
          style: TextStyle(color: Color.fromARGB(255, 13, 181, 81)),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Movie>>(
                stream: BlocProvider.of<FavoriteBloc>(context).outFav,
                builder: (context, snapshot){
                  if(snapshot.hasData) return Text("${snapshot.data.length}");
                  else return Container();
                }
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>Favorites())
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              if(result != null) bloc.inSearch.add(result);
            },
          )
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
          stream: bloc.outMovies,
          initialData: [],
          builder: (context, snapshot){
            if(snapshot.hasData)
              return ListView.builder(
                itemBuilder: (context, index){
                  if(index < snapshot.data.length){
                    return MovieTile(snapshot.data[index]);
                  } else if (index > 1){
                    bloc.inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data.length + 1,
              );
            else
              return Container();
          }
      ),
    );
  }
}
