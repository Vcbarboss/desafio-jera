import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:catalogo/models/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase{




  Map<String, Movie> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Movie>>();
  Stream<Map<String, Movie>> get outFav => _favController.stream;

  FavoriteBloc(){
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getKeys().contains("favorites")){
        _favorites = json.decode(prefs.getString("favorites")).map((k,v){
          return MapEntry(k, Movie.fromJson(v));
        }).cast<String, Movie>();
        _favController.add(_favorites);
      }
    });
  }
  
  void toggleFavorite(Movie movie){
    if(_favorites.containsKey(movie.id)) _favorites.remove(movie.id);
    else _favorites[movie.id] = movie;

    _favController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("favorites", json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
  }

}